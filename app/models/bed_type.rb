class BedType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :bed_preferences
  has_many :hospital_bed_availabilities
end
