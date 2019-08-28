class Task < ApplicationRecord
  belongs_to :performer, class_name: 'User', foreign_key: 'performer_id', optional: true
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :project
  has_many :time_logs, dependent: :destroy

  enum task_type: { feature: 0, bug: 1 }
  enum priority: { hot: 3, high: 2, normal: 1 }

  validates :name, presence: true, length: { maximum: 140 }
  validates :task_type, presence: true
  validates :author, :project, presence: true, on: :create
  validates :start_date, :due_date, presence: true

  default_scope { order(created_at: :desc) }

  before_save :before_save_send_emails

  def badges
    [self.task_type, self.priority].compact
  end

  private

  def before_save_send_emails
    return unless changed?

    [author, performer].compact.each do |user|
      TaskMailer.with(user: user, task: self, updates: changes.to_json).update_email.deliver_later
    end
  end
end
