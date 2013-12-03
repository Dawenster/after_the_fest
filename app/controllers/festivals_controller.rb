class FestivalsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:index, :show]

  def index
    @festivals = Festival.order("lower(name) ASC")
    @key_input = KeyInput.last
  end

  def show
    @festival = Festival.find_by_slug(params[:slug])
  end

  def admin_index
    @festivals = Festival.order("lower(name) ASC")
  end

  def new
    @festival = Festival.new
  end

  def create
    params = convert_param_boolean
    params = convert_param_dates
    @festival = Festival.new(params[:festival])
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
    params = convert_param_boolean
    params = convert_param_dates
    @festival.assign_attributes(params[:festival])
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

  private

  def convert_param_boolean
    params[:festival][:show_date] = params[:festival][:show_date] == "Yes" ? true : false
    return params
  end

  def convert_param_dates
    params[:festival][:start] = convert_to_date_object(params[:festival][:start])
    params[:festival][:end] = convert_to_date_object(params[:festival][:end])
    return params
  end

  def convert_to_date_object(str)
    Time.zone = cookies["jstz_time_zone"]
    DateTime.strptime(str, "%m/%d/%Y").end_of_day
  end
end