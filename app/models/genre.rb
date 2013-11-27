class Genre < ActiveRecord::Base
  attr_accessible :name, :film_ids => []

  validates :name, :presence => true
  
  has_and_belongs_to_many :films
end