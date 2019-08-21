class AddDefaultValueForUsersAdmin < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :admin, :boolean, default: false
  end
end
