class CreateBillboards < ActiveRecord::Migration[5.2]
  def change
    create_table :billboards do |t|
      t.string :photo
      t.string :address
      t.integer :price

      t.timestamps
    end
  end
end
