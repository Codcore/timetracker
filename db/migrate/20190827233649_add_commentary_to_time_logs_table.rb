class AddCommentaryToTimeLogsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :time_logs, :commentary, :string
  end
end
