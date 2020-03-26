class User < ActiveRecord::Base
  has_secure_password
  has_many :book
  

  validates :username, :presence => true,
                       :uniqueness => true 
  validates :email,    :presence => true,
                       :uniqueness => true
  validates :password, :presence => true 
end

#Validations mean a User object won't ever be saved unless they meet this criteria. The above code says that a User cannot exist in the database unless it has

#a username (unique)
#an email address (unique)
#a password

