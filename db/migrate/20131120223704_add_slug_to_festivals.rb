class AddSlugToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :slug, :string
  end
end
