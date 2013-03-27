class HospitalPreference < ActiveRecord::Base
  attr_accessible :hospital_id, :request_id

  belongs_to :hospital, :inverse_of => :hospital_preferences
  belongs_to :request,  :inverse_of => :hospital_preferences

  validates :hospital,  :presence => true
  validates :request,   :presence => true
end
