class KeyInput < ActiveRecord::Base
  attr_accessible :about_blurb, :about_full, :terms_and_conditions, :up_vote_message, :down_vote_message, :blocked_image,
                  :unavailable_image

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :blocked_image,
                    :styles => { :thumb => "156x88#", :display => "780x440#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  has_attached_file :unavailable_image,
                    :styles => { :thumb => "156x88#", :display => "780x440#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"
end