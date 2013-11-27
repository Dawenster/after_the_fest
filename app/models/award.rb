class Award < ActiveRecord::Base
  attr_accessible :name, :image, :film_ids => []

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :image,
                    :styles => { :thumb => "100x100#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  validates :name, :presence => true
  
  has_and_belongs_to_many :films
end