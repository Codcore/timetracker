class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :project, foreign_key: true
      t.references :author, foreign_key: { to_table: :users }
      t.string :body

      t.timestamps
    end
  end
end
