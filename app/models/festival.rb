class Festival < ActiveRecord::Base
  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :logo, 
                    :styles => { :thumb => "100x100>" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  has_attached_file :banner,
                    :styles => { :thumb => "300x150>" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  validates :name, :presence => true
  validates :festival_url, :presence => true
  validates :logo, :presence => true
  validates :banner, :presence => true

  before_save :create_slug

  has_many :films

  def create_slug
    self.slug = self.to_slug
  end

  def to_slug
    self.name.parameterize
  end
end