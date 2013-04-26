class StateHistory < ActiveRecord::Base
  attr_accessible :notes, :request_id, :state

  belongs_to :request
  belongs_to :user

  #validates_presence_of :request, :user, :state
  validates_presence_of :request, :state
  
end
