class Diagnosis < ActiveRecord::Base
  attr_accessible :name
  
  has_many :requests
  has_many :diagnosis_details
end
