class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :practice_id, :transfer_center_id
  
  has_many :requests, foreign_key: :user_created_by
  has_many :requests, foreign_key: :user_updated_by
  has_many :state_histories

  belongs_to :practice
  belongs_to :transfer_center

  def transfer_center_user?
    self.roles.map {|x| x.name}.include?("transfer_center")
  end

  def provider_user?
    self.roles.map {|x| x.name}.include?("provider")
  end
end
