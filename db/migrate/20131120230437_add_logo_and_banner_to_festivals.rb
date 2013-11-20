class AddLogoAndBannerToFestivals < ActiveRecord::Migration
  def change
    add_attachment :festivals, :logo
    add_attachment :festivals, :banner
  end
end
