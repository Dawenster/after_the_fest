class PagesController < ApplicationController
  def about_us
    @key_input = KeyInput.last
  end

  def contact_us
  end

  def terms_and_conditions
    @key_input = KeyInput.last
  end
end