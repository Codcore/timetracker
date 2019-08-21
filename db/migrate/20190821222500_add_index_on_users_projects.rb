class AddIndexOnUsersProjects < ActiveRecord::Migration[5.2]
  def change
    remove_index :projects_users, name: "index_projects_users_on_project_id_and_user_id"
  end
end
