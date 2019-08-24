class ChangeColumnTypeTasksPriorityToInteger < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :priority, :integer
  end
end
