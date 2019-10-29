class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :billboard_id
      t.integer :price
    end
  end
end
