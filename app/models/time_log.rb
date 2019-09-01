class TimeLog < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: "User", foreign_key: :author_id

  validates :hours, numericality: { less_than: 10, greater_than: 0 }, presence: true

  def self.for_task_and_user(task, current_user)
    return TimeLog.where(task_id: task.id) if current_user.admin?
    TimeLog.where("task_id = ? AND author_id = ?", task.id, current_user.id)
  end

  def self.for_author_user(current_user)
    return TimeLog.all if current_user.admin?
    TimeLog.where("author_id = ?", current_user.id)
  end

end
