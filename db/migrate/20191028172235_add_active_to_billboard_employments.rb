class AddActiveToBillboardEmployments < ActiveRecord::Migration[5.2]
  def change
    add_column :billboard_employments, :active, :boolean, default: true
  end
end
