class AddLocationDetailsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :name, :string
    add_column :locations, :city, :string
    add_column :locations, :state_or_province, :string
    add_column :locations, :country, :string
  end
end
