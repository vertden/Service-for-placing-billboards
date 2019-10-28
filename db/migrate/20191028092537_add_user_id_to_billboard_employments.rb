class AddUserIdToBillboardEmployments < ActiveRecord::Migration[5.2]
  def change
    add_column :billboard_employments, :iser_id, :integer
  end
end
