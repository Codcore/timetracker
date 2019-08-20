class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.date :date_of_birth
      t.string :position
      t.string :email, null: false

      t.timestamps
    end
  end
end
