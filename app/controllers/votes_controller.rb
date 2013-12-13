class VotesController < ApplicationController
  protect_from_forgery except: :create

  def create
    respond_to do |format|
      vote = Vote.new
      vote.ip_address = request.location.data["ip"]
      film = Film.find(params[:film_id])
      vote.film_id = film.id
      message = params[:vote_type] == "up" ? KeyInput.last.up_vote_message : KeyInput.last.down_vote_message
      if unique_ip?(vote) && vote.save
        count = film.increment_vote(params[:vote_type])
        format.json { render :json => { :message => message, :count => count, :vote_type => params[:vote_type] }, :status => :ok }
      else
        format.json { render :json => { :message => vote.errors.messages }, :status => :unprocessable_entity }
      end
    end
  end

  private

  def unique_ip?(vote)
    !vote.film.votes.map{ |v| v.ip_address }.include?(vote.ip_address)
  end
end