require 'securerandom'

class Project < ApplicationRecord

  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :slug, presence: true, on: :create
  validates :slug, uniqueness: true, on: :create
  validates :author, presence: true, on: :create

  before_save :before_save_create_slug

  def to_param
    slug
  end

  private

    def before_save_create_slug
      self.slug = SecureRandom.hex unless self.slug
    end
end
