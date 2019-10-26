class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :second_name, :string
    add_column :users, :nickname, :string
    add_column :users, :avatar, :string
    add_column :users, :birthday, :date
    add_column :users, :address, :string
  end
end
