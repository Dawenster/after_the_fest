class AddDatesAndStatusToFestivals < ActiveRecord::Migration
  def change
    add_column :festivals, :start, :datetime
    add_column :festivals, :end, :datetime
    add_column :festivals, :status, :string
    add_column :festivals, :show_date, :boolean
  end
end
