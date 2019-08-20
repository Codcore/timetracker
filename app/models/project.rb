require 'SecureRandom'

class Project < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, on: :save
  validates :slug, uniqueness: true

  before_save :create_slug

  private

    def create_slug
      self.slug = SecureRandom.hex
    end

end
