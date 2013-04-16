class Request < ActiveRecord::Base
  attr_accessible :complaint, :patient_dob, :patient_name_first, :patient_name_last, 
                  :patient_ssn, :physician_flag, :provider_callback_phone, :provider_id, 
                  :transfer_center_id, :hospital_preferences_attributes, :bed_preferences_attributes,
                  :hospital_bed_availabilities_attributes, :user_created_by, :user_updated_by,
                  :diagnosis_id, :diagnosis_detail_id

  belongs_to :provider
  belongs_to :transfer_center 
  belongs_to :diagnosis
  belongs_to :diagnosis_detail
  belongs_to :user, foreign_key: :user_created_by 
  belongs_to :user, foreign_key: :user_updated_by 

  has_many :hospital_preferences,        :dependent => :destroy  
  has_many :bed_preferences,             :dependent => :destroy
  has_many :hospital_bed_availabilities, :dependent => :destroy
  
  accepts_nested_attributes_for :hospital_preferences,        :allow_destroy => true
  accepts_nested_attributes_for :bed_preferences,             :allow_destroy => true
  accepts_nested_attributes_for :hospital_bed_availabilities, :allow_destroy => true
  
  validates :provider,        :presence => true
  validates :transfer_center, :presence => true
  validates :user_created_by, :presence => true
  validates :user_updated_by, :presence => true, on: :update
  validates :diagnosis, :presence => true
  validates :diagnosis_detail, :presence => true
  
  validates_presence_of :complaint, :patient_dob, :patient_name_first, :patient_name_last
end
