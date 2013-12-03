class Festival < ActiveRecord::Base
  attr_accessible :name, :festival_url, :logo, :banner, :background_colour, :slug, :start, :end, :status, :show_date

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :logo, 
                    :styles => { :thumb => "100x70#", :display => "400x280#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  has_attached_file :banner,
                    :styles => { :thumb => "300x150>" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  validates :name, :presence => true
  validates :background_colour, :presence => true
  validates :slug, :presence => true
  validates :festival_url, :presence => true
  validates :logo, :presence => true
  validates :banner, :presence => true

  has_many :films

  def genres
    self.films.map{ |film| film.genres }.flatten.uniq.sort_by{ |film| film.name }
  end
end