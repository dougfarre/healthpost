class TransferCenter < ActiveRecord::Base
  attr_accessible :name

  has_many :requests
  has_many :practices
  has_many :hospitals
  has_many :users
end
