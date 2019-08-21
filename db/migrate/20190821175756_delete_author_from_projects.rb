class DeleteAuthorFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :author_id
  end
end
