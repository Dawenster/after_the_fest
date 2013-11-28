class SearchesController < ApplicationController
  def search
    q = "%#{params[:query].downcase.gsub(' ', '-')}%"
    @films = Film.where("slug LIKE ?", q)
  end
end