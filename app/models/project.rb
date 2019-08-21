require 'securerandom'

class Project < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, on: :save
  validates :slug, uniqueness: true, on: :save

  before_save :create_slug

  def to_param
    slug
  end

  private

    def create_slug
      self.slug = SecureRandom.hex
    end
end
