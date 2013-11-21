class Film < ActiveRecord::Base
  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :image,
                    :styles => { :thumb => "100x100>" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  validates :name, :presence => true
  validates :embed_url, :presence => true

  before_save :create_slug

  belongs_to :festival

  def create_slug
    self.slug = self.to_slug
  end

  def to_slug
    self.name.parameterize
  end
end