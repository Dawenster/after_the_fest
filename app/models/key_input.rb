class KeyInput < ActiveRecord::Base
  attr_accessible :about_blurb, :about_full, :terms_and_conditions, :up_vote_message, :down_vote_message
end