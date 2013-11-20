class Festival < ActiveRecord::Base
  has_attached_file :logo, :styles => { :medium => "200x150>", :thumb => "100x100>" }
  has_attached_file :banner, :styles => { :medium => "700x300>" }

  validates :name, :presence => true
  validates :festival_url, :presence => true
  validates :logo, :presence => true
  validates :banner, :presence => true
end