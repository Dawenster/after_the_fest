class Comment < ActiveRecord::Base
  validates :content, :presence => true

  belongs_to :film
end