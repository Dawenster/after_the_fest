class SearchesController < ApplicationController
  def search
    q = "%#{params[:query]}%"
    @films = Film.where("slug LIKE ?", q)
  end
end