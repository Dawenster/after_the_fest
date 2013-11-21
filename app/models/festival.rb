class Festival < ActiveRecord::Base
  has_attached_file :logo, :styles => { :thumb => "100x100>" }
  has_attached_file :banner, :styles => { :thumb => "300x150>" }

  validates :name, :presence => true
  validates :festival_url, :presence => true
  validates :logo, :presence => true
  validates :banner, :presence => true

  before_save :create_slug

  def create_slug
    self.slug = self.to_slug
  end

  def to_slug
    self.name.parameterize
  end
end