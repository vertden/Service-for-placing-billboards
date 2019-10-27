class CreateBillboardEmployments < ActiveRecord::Migration[5.2]
  def change
    create_table :billboard_employments do |t|
      t.text :body
      t.string :brand
      t.string :adv_type
      t.integer :duration
      t.date :start_date
      t.integer :billboard_id

      t.timestamps
    end
  end
end
