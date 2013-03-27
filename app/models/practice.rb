class Practice < ActiveRecord::Base
  attr_accessible :name, :transfer_center_id

  belongs_to :transfer_center

  has_many :providers

  validates :transfer_center, :presence => true
end
