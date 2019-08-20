class User < ApplicationRecord
  validates :email, :name, :surname, presence: true
end
