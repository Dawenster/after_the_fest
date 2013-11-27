class CommentsController < ApplicationController
  protect_from_forgery except: :create

  def create
    respond_to do |format|
      puts "*" * 100
      puts params
      params["comment"]["film_id"] = params["comment"]["film_id"].to_i
      comment = Comment.new(params["comment"])
      if simple_captcha_valid? && comment.save
        format.json { render :json => { :message => "Success!" }, :status => :ok }
      else
        format.json { render :json => { :message => comment.errors.messages }, :status => :unprocessable_entity }
      end
    end
  end
end