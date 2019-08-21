require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :projects

  validates :name, :surname, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :password, length: { minimum: 6 }, confirmation: { case_sensitive: true }, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
