class AddImageToFilms < ActiveRecord::Migration
  def change
    add_attachment :films, :image
  end
end
