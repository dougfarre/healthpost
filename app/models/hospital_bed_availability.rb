class HospitalBedAvailability < ActiveRecord::Base
  attr_accessible :bed_type_id, :hospital_id, :request_id
  
  belongs_to :request,  :inverse_of => :hospital_bed_availabilities 
  belongs_to :hospital, :inverse_of => :hospital_bed_availabilities 
  belongs_to :bed_type, :inverse_of => :hospital_bed_availabilities 
  
  validates :request,   :presence => true
  validates :hospital,  :presence => true
  validates :bed_type,  :presence => true

  validates_uniqueness_of :request_id, scope: [:hospital_id, :bed_type_id]

  def self.prepare_nested_form(request)
    hospitals = request.transfer_center.hospitals
    hospital_bed_availabilities = Array.new

    hospitals.each do |hospital|
      hospital_bed_availabilities << HospitalBedAvailability.new(hospital_id: hospital.id)
    end
    logger.debug hospital_bed_availabilities
 
    return hospital_bed_availabilities
  end
end
