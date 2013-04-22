class BedPreference < ActiveRecord::Base
  attr_accessible :bed_type_id, :request_id

  belongs_to :bed_type
  belongs_to :request, inverse_of: :bed_preferences 

  validates :bed_type,  :presence => true
  validates :request,   :presence => true
end
