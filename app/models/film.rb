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
                  :genre_ids,
                  :awards_ids,
                  :location_ids

  s3_credentials_hash = {
    :access_key_id => ENV['AWS_ACCESS_KEY'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  has_attached_file :image,
                    :styles => { :thumb => "100x100>", :display => "380x400#" },
                    :s3_credentials => s3_credentials_hash,
                    :bucket => "afterthefest"

  validates :name, :presence => true
  validates :embed_url, :presence => true

  before_save :create_slug

  belongs_to :festival
  has_many :votes
  has_many :comments
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :awards
  has_and_belongs_to_many :locations

  def create_slug
    self.slug = self.to_slug
  end

  def to_slug
    self.name.parameterize
  end

  def popover_content
    return content = <<-eos
      <strong>Directed by:</strong> #{self.director}<br>
      <strong>Writer:</strong> #{self.writer}<br>
      <strong>Starring:</strong> #{self.starring}<br>
      <br>
      #{truncate(self.description, length: 100, omission: "... ")} #{"<a href=/#{self.festival.slug}/#{self.slug}>more</a>" if self.description.length > 100}<br>
      <br>
      #{'<strong>Awards: </strong>' + self.awards.map{|award| award.name}.join(', ') + '<br>' if self.awards.any?}
      <strong>Run time:</strong> #{self.run_time} mins<br>
      <strong>Screening:</strong> #{self.screening}<br>
      <strong>Available:</strong> #{self.available_range}
    eos
  end

  def available_range
    "#{self.start.strftime('%b')} #{self.start.day.ordinalize} to #{self.end.strftime('%b')} #{self.end.day.ordinalize}"
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
    Time.now >= self.start && Time.now <= self.end
  end
end