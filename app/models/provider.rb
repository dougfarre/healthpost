class Provider < ActiveRecord::Base
  attr_accessible :name, :practice_id

  belongs_to :practice

  validates :practice, :presence => true
end
