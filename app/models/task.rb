class Task < ApplicationRecord
  belongs_to :performer, class_name: 'User', foreign_key: 'performer_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :project

  enum type: %w(feature bug)
  enum priority: { hot: 3, high: 2, normal: 1 }

  validates :name, presence: true, length: { maximum: 140 }
  validates :type, presence: true
  validates :author, :project, presence: true, on: :create
end
