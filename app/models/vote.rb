class Vote < ActiveRecord::Base
  validates :ip_address, :uniqueness => true

  belongs_to :film
end