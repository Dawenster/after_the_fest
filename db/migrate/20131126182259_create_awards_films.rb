class CreateAwardsFilms < ActiveRecord::Migration
  def change
    create_table :awards_films do |t|
      t.belongs_to :award
      t.belongs_to :film
    end
  end
end
