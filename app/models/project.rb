require 'securerandom'

class Project < ApplicationRecord

  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_and_belongs_to_many :users
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true, on: :save
  validates :author, presence: true

  before_save :before_save_create_slug

  def to_param
    slug
  end

  private

    def before_save_create_slug
      self.slug = SecureRandom.hex unless self.slug
    end
end
