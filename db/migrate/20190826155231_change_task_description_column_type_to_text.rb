class ChangeTaskDescriptionColumnTypeToText < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :description, :text
  end
end
