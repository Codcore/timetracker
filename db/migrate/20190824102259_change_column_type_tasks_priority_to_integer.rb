class ChangeColumnTypeTasksPriorityToInteger < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :complete_hours, :integer
  end
end
