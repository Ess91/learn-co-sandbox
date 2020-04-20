 class User < ActiveRecord::Base
  
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  
  has_secure_password
  has_many :book
  
end


