class Vote < ActiveRecord::Base
  attr_accessible :ip_address, :film_id

  belongs_to :film
end