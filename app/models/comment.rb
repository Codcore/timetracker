class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :body, presence: true, length: { minimum: 25, maximum: 600 }

  default_scope { order(created_at: :desc) }
end