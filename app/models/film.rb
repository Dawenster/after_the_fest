class Film < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

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
  has_and_belongs_to_many :genres

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
      <strong>Run time:</strong> #{self.run_time} mins<br>
      <strong>Screening:</strong> #{self.screening}<br>
      <strong>Available:</strong> #{self.available_range}
    eos
  end

  def available_range
    "#{self.start.strftime('%b')} #{self.start.day.ordinalize} to #{self.end.strftime('%b')} #{self.end.day.ordinalize}"
  end
end