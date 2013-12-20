class AddMobileBannerToFestivals < ActiveRecord::Migration
  def change
    add_attachment :festivals, :mobile_banner
  end
end
