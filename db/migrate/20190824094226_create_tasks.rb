class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description
      t.date :start_date
      t.date :due_date
      t.string :type, null: false
      t.string :priority
      t.string :complete_hours
      t.references :performer, foreign_key: { to_table: :users }
      t.references :author, foreign_key: { to_table: :users }
      t.references :project, foreign_key: true

      t.timestamp
    end
  end
end
