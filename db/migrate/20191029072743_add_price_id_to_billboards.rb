class AddPriceIdToBillboards < ActiveRecord::Migration[5.2]
  def change
    add_column :billboards, :price_id, :integer
  end
end
