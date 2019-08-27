class CreateTimeLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :time_logs do |t|
      t.belongs_to :task
      t.integer :hours
      t.timestamps
    end
  end
end
