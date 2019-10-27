class AddLocationToBillboards < ActiveRecord::Migration[5.2]
  def change
    add_column :billboards, :latitude, :float
    add_column :billboards, :longitude, :float
  end
end
