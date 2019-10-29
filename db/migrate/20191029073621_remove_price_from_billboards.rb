class RemovePriceFromBillboards < ActiveRecord::Migration[5.2]
  def change
    remove_column :billboards, :price, :integer
  end
end
