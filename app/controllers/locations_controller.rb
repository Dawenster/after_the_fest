class LocationsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD']

  def index
    @locations = Location.order("lower(name) ASC")
  end

  def new
    @location = Location.new
  end

  def create
    set_name_as_input_address
    @location = Location.new(params)
    if @location.save
      flash[:success] = "#{@location.name} has been successfully created."
      redirect_to locations_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "new"
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    set_name_as_input_addressy
    @location = Location.find(params[:id])
    @location.assign_attributes(params)
    if @location.save
      flash[:success] = "#{@location.name} has been successfully updated."
      redirect_to locations_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "edit"
    end
  end

  def destroy
    location = Location.find(params[:id]).destroy
    flash[:success] = "#{location.name} has been deleted."
    redirect_to locations_path
  end

  private

  def set_name_as_input_address
    params[:location][:name] = params[:location][:address]
  end
end