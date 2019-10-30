class AddAdvTypeAndBrandToBillboards < ActiveRecord::Migration[5.2]
  def change
    add_column :billboards, :adv_type, :string, null: true
    add_column :billboards, :brand, :string, null: true
  end
end
