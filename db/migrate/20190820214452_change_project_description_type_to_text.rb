class ChangeProjectDescriptionTypeToText < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :description, :text
  end
end
