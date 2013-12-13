class KeyInputsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD']

  def about_edit
    @key_input = KeyInput.last
  end

  def terms_edit
    @key_input = KeyInput.last
  end

  def vote_messages
    @key_input = KeyInput.last
  end

  def update
    @key_input = KeyInput.last
    @key_input.assign_attributes(params[:key_input])
    if @key_input.save
      flash[:success] = "Your info has been successfully updated."
      if params[:key_input][:about_blurb].present?
        redirect_to about_edit_path
      elsif params[:key_input][:up_vote_message].present?
        redirect_to vote_messages_edit_path
      else
        redirect_to terms_edit_path
      end
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "edit"
    end
  end
end