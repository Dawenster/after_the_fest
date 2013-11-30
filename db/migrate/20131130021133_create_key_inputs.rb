class CreateKeyInputs < ActiveRecord::Migration
  def change
    create_table :key_inputs do |t|
      t.text :about_blurb
      t.text :about_full
      t.text :terms_and_conditions

      t.timestamps
    end
  end
end
