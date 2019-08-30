class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.date :start_date
      t.date :due_date
      t.integer :task_type, null: false
      t.integer :priority
      t.integer :complete_hours
      t.references :performer, foreign_key: { to_table: :users }
      t.references :author, foreign_key: { to_table: :users }
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
