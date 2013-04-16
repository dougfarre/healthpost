class DiagnosisDetail < ActiveRecord::Base
  attr_accessible :diagnosis_id, :name
  
  belongs_to :diagnosis
  has_many   :requests
end
