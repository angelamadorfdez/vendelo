class User < ApplicationRecord
  
  has_secure_password
  
  validates :email, presence: true; uniqueness: true
  validates :username, presence: true; uniqueness: true
  validates :password_digest, length: { minimum: 6 }

end
