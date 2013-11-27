class FestivalsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:index, :show]

  def index
    @festivals = Festival.order("lower(name) ASC")
  end

  def show
    @festival = Festival.find_by_slug(params[:slug])
  end

  def admin_index
    @festivals = Festival.all
  end

  def new
    @festival = Festival.new
  end

  def create
    @festival = Festival.new(festival_params)
    if @festival.save
      flash[:success] = "#{@festival.name} has been successfully created."
      redirect_to admin_festivals_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "new"
    end
  end

  def edit
    @festival = Festival.find(params[:id])
  end

  def update
    @festival = Festival.find(params[:id])
    @festival.assign_attributes(festival_params)
    if @festival.save
      flash[:success] = "#{@festival.name} has been successfully updated."
      redirect_to admin_festivals_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "edit"
    end
  end

  def destroy
    festival = Festival.find(params[:id]).destroy
    flash[:success] = "#{festival.name} has been deleted."
    redirect_to admin_festivals_path
  end
end