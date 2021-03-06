class AwardsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:index]

  def index
    @festival = Festival.find_by_slug(params[:festival])
    @awards = @festival.films.map{ |f| f.awards }.flatten.sort_by{ |a| a.name }
  end

  def admin_index
    @awards = Award.order("lower(name) ASC")
  end

  def new
    @award = Award.new
  end

  def create
    @award = Award.new(params[:award])
    if @award.save
      flash[:success] = "#{@award.name} has been successfully created."
      redirect_to admin_awards_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "new"
    end
  end

  def edit
    @award = Award.find(params[:id])
  end

  def update
    @award = Award.find(params[:id])
    @award.assign_attributes(params[:award])
    if @award.save
      flash[:success] = "#{@award.name} has been successfully updated."
      redirect_to admin_awards_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "edit"
    end
  end

  def destroy
    award = Award.find(params[:id]).destroy
    flash[:success] = "#{award.name} has been deleted."
    redirect_to admin_awards_path
  end
end