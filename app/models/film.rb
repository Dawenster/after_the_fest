class Film < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :name,
                  :embed_url,
                  :image,
                  :up_votes,
                  :down_votes,
                  :slug,
                  :festival_id,
                  :director,
                  :writer,
                  :starring,
                  :description,
                  :run_time,
                  :screening, 
                  :start,
                  :end,
                  :timezone_offset,
                  :official_url,
                  :genre_ids,
                  :award_ids,
                  :location_ids

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :image,
                    :styles => { :thumb => "70x100#", :display => "420x600#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  validates :name, :presence => true
  validates :embed_url, :presence => true

  before_save :create_slug

  belongs_to :festival
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :awards
  has_and_belongs_to_many :locations

  def self.format_films_for_search(films)
    formatted_films = []
    films.each_with_index do |film, i|
      formatted_films << {
        "value" => film.name.truncate(28),
        "link" => "/#{film.festival.slug}/#{film.slug}",
        "festival" => film.festival.name.truncate(38),
        "icon" => film.image.url(:thumb),
        "styleId" => "search-item-#{i + 1}"
      }
    end
    return formatted_films
  end

  def create_slug
    self.slug = self.to_slug
  end

  def to_slug
    self.name.parameterize
  end

  def popover_content
    genres = []
    self.genres.each do |genre|
      genres << "<strong><a href=/#{self.festival.slug}/genres?type=#{genre.name}>#{genre.name}</a></strong>"
    end
    FilmsController.new.render_to_string(:partial => 'films/popover_content', :locals => { :film => self, :genres => genres })
  end

  def available_range
    str = "From #{self.start.strftime('%b')} #{self.start.day.ordinalize}" if self.start
    str += "#{self.start ? ' until' : 'Until'} #{self.end.strftime('%b')} #{self.end.day.ordinalize}" if self.end
    return str
  end

  def increment_vote(vote_type)
    if vote_type == "up"
      self.update_attributes(:up_votes => self.up_votes += 1)
      return self.up_votes
    else
      self.update_attributes(:down_votes => self.down_votes += 1)
      return self.down_votes
    end
  end

  def available?
    start_time = self.start ? self.start : Time.now - 1
    end_time = self.end ? self.end : Time.now + 1
    Time.now >= start_time && Time.now <= end_time
  end
end