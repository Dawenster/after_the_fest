class AddFilmDetailsToFilms < ActiveRecord::Migration
  def change
    add_column :films, :director, :string
    add_column :films, :writer, :string
    add_column :films, :starring, :string
    add_column :films, :description, :text
    add_column :films, :run_time, :integer
    add_column :films, :screening, :string
    add_column :films, :start, :datetime
    add_column :films, :end, :datetime
  end
end
