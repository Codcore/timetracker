class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :body, presence: true, length: { minimum: 50, maximum: 600 }
end
