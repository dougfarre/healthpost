class HospitalBedAvailability < ActiveRecord::Base
  attr_accessible :bed_type_id, :hospital_id, :request_id
end
