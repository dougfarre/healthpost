class Hospital < ActiveRecord::Base
  attr_accessible :name, :transfer_center_id

  belongs_to :transfer_center

  has_many :hospital_bed_availabilities
  has_many :hospital_preferences
  
  validates :name, :presence => true
  validates :transfer_center, :presence => true

end
