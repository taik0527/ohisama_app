class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

end
