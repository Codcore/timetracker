class AddAuthorToTimeLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :time_logs, :author, references: :users
  end
end
