class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :nickname
      t.text :body
      t.integer :billboard_id

      t.timestamps
    end
  end
end
