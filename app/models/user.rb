class User < ApplicationRecord
  require 'json'
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
