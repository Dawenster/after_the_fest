class AddImageToAwards < ActiveRecord::Migration
  def change
    add_attachment :awards, :image
  end
end
