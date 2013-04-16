class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, 
                  :practice_id, :transfer_center_id
  
  has_many :requests, foreign_key: :user_created_by
  has_many :requests, foreign_key: :user_updated_by

  belongs_to :practice
  belongs_to :transfer_center
end
