class AddTimestampsToTask < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :tasks
  end
end
