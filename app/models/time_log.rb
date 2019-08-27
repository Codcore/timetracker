class TimeLog < ApplicationRecord
  belongs_to :task

  validates :hours, numericality: { less_than: 10, greater_than: 0 }, presence: true
end
