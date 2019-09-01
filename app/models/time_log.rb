class TimeLog < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: "User", foreign_key: :author_id

  validates :hours, numericality: { less_than: 10, greater_than: 0 }, presence: true

  def self.for_task_and_user(task, current_user)
    return TimeLog.where(task_id: task.id) if current_user.admin?
    TimeLog.all.where("task_id = ? AND author_id = ?", task.id, current_user.id)
  end

end
