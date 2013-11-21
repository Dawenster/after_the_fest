class Festival < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  has_attached_file :banner, :styles => { :thumb => "300x150>" }

  validates :name, :presence => true
  validates :festival_url, :presence => true
  validates :logo, :presence => true
  validates :banner, :presence => true
end