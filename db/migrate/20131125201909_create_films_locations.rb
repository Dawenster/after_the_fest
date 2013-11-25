class CreateFilmsLocations < ActiveRecord::Migration
  def change
    create_table :films_locations do |t|
      t.belongs_to :film
      t.belongs_to :location
    end
  end
end
