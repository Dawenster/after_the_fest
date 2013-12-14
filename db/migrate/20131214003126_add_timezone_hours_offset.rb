class AddTimezoneHoursOffset < ActiveRecord::Migration
  def change
    add_column :films, :timezone_offset, :integer
    add_column :festivals, :timezone_offset, :integer
  end
end
