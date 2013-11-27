class Location < ActiveRecord::Base
  attr_accessible :address, :name, :location_type, :latitude, :longitude, :city, :state_or_province, :country, :film_ids => []

  has_and_belongs_to_many :films

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  geocoded_by :address do |location,results|
    if result = results.first
      location.address = result.address
      location.latitude = result.latitude
      location.longitude = result.longitude
      location.city = result.city
      location.state_or_province = result.state
      location.country = result.country
    end
  end
end