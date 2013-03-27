class HospitalBedAvailability < ActiveRecord::Base
  attr_accessible :bed_type_id, :hospital_id, :request_id
  
  belongs_to :request,  :inverse_of => :hospital_bed_availabilities 
  belongs_to :hospital, :inverse_of => :hospital_bed_availabilities 
  belongs_to :bed_type, :inverse_of => :hospital_bed_availabilities 
  
  validates :request,   :presence => true
  validates :hospital,  :presence => true
  validates :bed_type,  :presence => true
end
