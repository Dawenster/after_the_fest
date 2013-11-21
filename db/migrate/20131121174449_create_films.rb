class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :name
      t.text :embed_url
      t.integer :up_votes, :default => 0
      t.integer :down_votes, :default => 0
      t.integer :festival_id

      t.timestamps
    end
  end
end
