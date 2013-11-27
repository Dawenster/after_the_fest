class CommentsController < ApplicationController
  protect_from_forgery except: :create

  def create
    respond_to do |format|
      puts "*" * 100
      puts params
      params["comment"]["film_id"] = params["comment"]["film_id"].to_i
      comment = Comment.new(params["comment"])
      if simple_captcha_valid? && comment.save
        results = {
          :comment => render_to_string(:partial => "individual_comment.html.slim", :locals => { :comment => comment }),
          :captcha => render_to_string(:partial => "captcha.html.slim")
        }
        format.json { render :json => results }
      else
        format.json { render :json => { :message => "Something went wrong - please try again." }, :status => :unprocessable_entity }
      end
    end
  end
end