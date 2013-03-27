class TransferCenter < ActiveRecord::Base
  attr_accessible :name

  has_many :practices
  has_many :hospitals
end
