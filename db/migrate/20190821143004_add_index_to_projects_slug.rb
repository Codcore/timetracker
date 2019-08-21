class AddIndexToProjectsSlug < ActiveRecord::Migration[5.2]
  def change
    add_index :projects, :slug
  end
end
