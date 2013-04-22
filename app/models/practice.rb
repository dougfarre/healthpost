class Practice < ActiveRecord::Base
  attr_accessible :name, :phone, :transfer_center_id

  belongs_to :transfer_center

  has_many :requests
  has_many :providers
  has_many :users

  validates :transfer_center, :presence => true
end
