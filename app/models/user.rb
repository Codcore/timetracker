require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  validates :email, :name, :surname, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: { case_sensitive: true }
end
