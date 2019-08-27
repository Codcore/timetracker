class ChangeTasksTaskTypeColumnTypeToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :task_type, :integer
  end
end
