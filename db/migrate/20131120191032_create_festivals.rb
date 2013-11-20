class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :festival_url
      t.string :logo
      t.string :banner
      t.string :background_colour

      t.timestamps
    end
  end
end
