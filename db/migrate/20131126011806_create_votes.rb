class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :ip_address
      t.integer :film_id

      t.timestamps
    end
  end
end
