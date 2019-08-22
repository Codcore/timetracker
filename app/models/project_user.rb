class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  self.table_name = :projects_users

  def to_param
    "#{project.id}/#{user.id}"
  end
end