class Request < ActiveRecord::Base
  attr_accessible :complaint, :patient_dob, :patient_name_first, :patient_name_last, 
                  :patient_ssn, :physician_flag, :provider_callback_phone, :provider_id, 
                  :transfer_center_id, :hospital_preferences_attributes, :bed_preferences_attributes,
                  :hospital_availabilities_attributes

  belongs_to :provider
  belongs_to :transfer_center 

  has_many :hospital_preferences, :dependent => :destroy  
  has_many :bed_preferences,      :dependent => :destroy

  has_many :hospital_bed_availabilities
  
  accepts_nested_attributes_for :hospital_preferences, :allow_destroy => true
  accepts_nested_attributes_for :bed_preferences, :allow_destroy => true
  
  validates :provider,        :presence => true
  validates :transfer_center, :presence => true

  validates_presence_of :complaint, :patient_dob, :patient_name_first, :patient_name_last
       
    
end
