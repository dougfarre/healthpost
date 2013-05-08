class Request < ActiveRecord::Base
  include AASM
  
  attr_accessible :complaint, :patient_dob, :patient_name_first, :patient_name_last, 
                  :patient_ssn, :physician_flag, :provider_callback_phone, :provider_id, 
                  :hospital_preferences_attributes, :bed_preferences_attributes,
                  :hospital_bed_availabilities_attributes, :bed_preference_ids,
                  :hospital_preference_ids, :diagnosis_id, :diagnosis_detail_id

  belongs_to :provider
  belongs_to :practice
  belongs_to :transfer_center 
  belongs_to :diagnosis
  belongs_to :diagnosis_detail
  belongs_to :user_created_by, foreign_key: :user_created_by, :class_name => "User"
  belongs_to :user_updated_by, foreign_key: :user_updated_by, :class_name => "User"

  has_many :hospital_preferences,        :dependent => :destroy, inverse_of: :request
  has_many :bed_preferences,             :dependent => :destroy, inverse_of: :request
  has_many :hospital_bed_availabilities, :dependent => :destroy
  has_many :state_histories,             :dependent => :destroy
  
  accepts_nested_attributes_for :hospital_preferences,        allow_destroy: true
  accepts_nested_attributes_for :bed_preferences,             allow_destroy: true
  accepts_nested_attributes_for :hospital_bed_availabilities, allow_destroy: true, reject_if: :all_blank
  
  attr_accessor :hospital_availabilities, :bed_availabilities, :transition

  validates :practice,        :presence => true
  validates :provider,        :presence => true
  validates :transfer_center, :presence => true
  validates :user_created_by, :presence => true
  validates :diagnosis,       :presence => true
  validates :diagnosis_detail,:presence => true
  validates :bed_preferences, :presence => true
  validates :user_updated_by, :presence => true, on: :update
  validates :hospital_preferences, :presence => true
  
  validates_presence_of :complaint, :patient_dob, :patient_name_first, :patient_name_last,
                        :patient_ssn, :provider_callback_phone

  before_validation :set_redundant_keys
  after_validation  :check_for_associations
  before_save       :perform_transition
  after_create      :set_default_phone
  after_save        :save_state_history

  aasm :column => :aasm_state  do
    state :new_request, initial: true 
    state :request_submitted 
    state :availability_submitted
    state :availability_approved #left ts 
    state :not_fulfilled
    state :reservation_confirmed
    state :canceled
    
    event :submit_request do
      transitions :from => :new_request, :to => :request_submitted
    end

    event :submit_availability do 
      transitions :from => :request_submitted, :to => :availability_submitted
    end
    
    event :decline_request do
      transitions :from => :request_submitted, :to => :not_fulfilled
    end

    event :approve_availability do
      transitions :from => :availability_submitted, :to => :availability_approved
    end

    event :decline_availability do
      transitions :from => [:availability_submitted], :to => :not_fulfilled
    end

    event :confirm_reservation do
      transitions :from => :availability_approved, :to => :reservation_confirmed
    end

    event :decline_reservation do
      transitions :from => [:availability_approved], :to => :not_fulfilled
    end
  end

  def self.get_ts_name_string(state_name)
    case state_name 
      when "request_submitted"
        "submit availability"
      when "availability_submitted"
        "awaiting review"
      when "availability_approved"
        "submit confirmation receipt"
    end
  end


  def self.get_provider_name_string(state_name)
    case state_name 
      when "new_request"
        "submit request"
      when "request_submitted"
        "awaiting availability"
      when "availability_submitted"
        "review availability"
      when "availability_approved"
        "awaiting confirmation receipt"
    end
  end

  def hospital_preference_ids=(preference_ids)
    hospitals = Hospital.where(transfer_center_id: Practice.find(self.practice_id).transfer_center_id)

    preference_ids.each do |id|
      if self.id.blank?
        self.hospital_preferences.build(hospital_id: id) unless id.blank?   
      else
        HospitalPreference.find_or_create_by_hospital_id_and_request_id(hospital_id: id, request_id: self.id) unless id.blank?
      end

      hospitals.delete_if {|x| x.id == id.to_i}
    end 

    hospitals.each do |hospital|
      HospitalPreference.destroy_all(hospital_id: hospital.id, request_id: self.id)
    end
  end

  def bed_preference_ids=(preference_ids)
    bed_types = BedType.all

    preference_ids.each do |id|
      if self.id.blank?
        self.bed_preferences.build(bed_type_id: id) unless id.blank?
      else
        BedPreference.find_or_create_by_bed_type_id_and_request_id(bed_type_id: id, request_id: self.id) unless id.blank?
      end
      bed_types.delete_if {|x| x.id == id.to_i}
    end 

    bed_types.each do |bed_type|
      BedPreference.destroy_all(bed_type_id: bed_type.id, request_id: self.id)
    end
  end

  def hospital_bed_availability_attributes=(attributes)
    @fail.boom
  end

  private

  def set_default_phone
    self.provider_callback_phone = self.provider.phone || self.provider.practice.phone unless self.provider_callback_phone
  end

  def set_redundant_keys
    unless self.provider.blank?
      self.practice_id = self.provider.practice_id unless self.practice_id
      self.transfer_center_id = self.practice.transfer_center.id unless self.transfer_center_id
    end
  end

  def save_state_history
    StateHistory.find_or_create_by_request_id_and_state(request_id: self.id, state: self.aasm_state)
  end

  def check_for_associations
    if self.aasm_state == "request_submitted" and self.transition != "decline_request"
      errors[:base] << "Associations can't be blank" if self.hospital_bed_availabilities.length < 1
      logger.debug "HI I MA HER                    "
    end
  end

  def perform_transition 
    self.send(self.transition) unless self.transition.blank?
  end
end
