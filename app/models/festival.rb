class Festival < ActiveRecord::Base
  validates :name, :presence => true
  validates :festival_url, :presence => true
  validates :logo, :presence => true
  validates :banner, :presence => true
end