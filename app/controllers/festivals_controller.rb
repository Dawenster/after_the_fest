class FestivalsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:index, :show]

  def index
    @now_playing = Festival.where(:status => "Now Playing").order("lower(name) ASC").limit(3)
    @coming_soon = Festival.where(:status => "Coming Soon").order("lower(name) ASC").limit(6)
    @recently_viewed = Festival.where(:status => "Recently Viewed").order("lower(name) ASC").limit(6)
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
    params = convert_param_dates if both_dates_entered?
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
    params = convert_param_dates if both_dates_entered?
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

  def both_dates_entered?
    !params[:festival][:start].blank? && !params[:festival][:end].blank?
  end

  def convert_param_boolean
    params[:festival][:show_date] = params[:festival][:show_date] == "true" ? true : false
    return params
  end

  def convert_param_dates
    params[:festival][:start] = convert_to_date_object(params[:festival][:start], "start")
    params[:festival][:end] = convert_to_date_object(params[:festival][:end], "end")
    set_timezone
    add_one_day if adjust_day?
    return params
  end

  def convert_to_date_object(str, period)
    Time.zone = cookies["jstz_time_zone"]
    if period == "start"
      return DateTime.strptime(str, "%m/%d/%Y").in_time_zone.beginning_of_day unless str.blank?
    else
      return DateTime.strptime(str, "%m/%d/%Y").in_time_zone.end_of_day unless str.blank?
    end
  end

  def set_timezone
    params[:festival][:timezone_offset] = params[:festival][:end].strftime("%z").to_i / 100
  end

  def adjust_day?
    params[:festival][:timezone_offset] < 0
  end

  def add_one_day
    params[:festival][:start] = params[:festival][:start] + 1.day
    params[:festival][:end] = params[:festival][:end] + 1.day
  end
end