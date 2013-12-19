class AddOfficialUrlToFilms < ActiveRecord::Migration
  def change
    add_column :films, :official_url, :string
  end
end
