class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :film_id

  validates :content, :presence => true

  belongs_to :film

  def formatted_comment
    return comment = <<-eos
      <div>
    eos
  end
end