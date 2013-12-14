class FilmsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'],
    :except => [:show, :searchable_films, :film_description]

  def searchable_films
    respond_to do |format|
      format.json { render :json => { :films => Film.all_films } }
    end
  end

  def film_description
    respond_to do |format|
      film = Film.find(params[:film_id])
      format.json { render :json => { :description => film.description, :id => film.id } }
    end
  end

  def show
    Time.zone = cookies["jstz_time_zone"]
    @film = Film.find_by_slug(params[:slug])
    @genres = []
    @film.genres.each do |genre|
      @genres << "<strong><a href=/#{@film.festival.slug}/genres?type=#{genre.name}>#{genre.name}</a></strong>"
    end
    @festival = @film.festival
    geoblock_result = geoblock?(@film)
    @geoblock = geoblock_result[0]
    @address = geoblock_result[1]
    @availability_block = !@film.available?
  end

  def admin_index
    @films = Film.order("lower(name) ASC")
  end

  def new
    @film = Film.new
  end

  def create
    params = convert_param_dates
    @film = Film.new(params[:film])
    if @film.save
      flash[:success] = "#{@film.name} has been successfully created."
      redirect_to admin_films_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "new"
    end
  end

  def edit
    @film = Film.find(params[:id])
  end

  def update
    @film = Film.find(params[:id])
    params = convert_param_dates
    @film.assign_attributes(params[:film])
    if @film.save
      flash[:success] = "#{@film.name} has been successfully updated."
      redirect_to admin_films_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "edit"
    end
  end

  def destroy
    film = Film.find(params[:id]).destroy
    flash[:success] = "#{film.name} has been deleted."
    redirect_to admin_films_path
  end

  private

  def convert_param_dates
    params[:film][:start] = convert_to_date_object(params[:film][:start], "start")
    params[:film][:end] = convert_to_date_object(params[:film][:end], "end")
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
    params[:film][:timezone_offset] = params[:film][:end].strftime("%z").to_i / 100
  end

  def adjust_day?
    params[:film][:timezone_offset] < 0
  end

  def add_one_day
    params[:film][:start] = params[:film][:start] + 1.day
    params[:film][:end] = params[:film][:end] + 1.day
  end

  def geoblock?(film)
    begin
      request_data = request.location.data
      address = address(request_data)
      return [false, address] if film.locations.empty? # No geoblocking set - anyone can watch
      return [false, "Local development"] if request_data["ip"] == "127.0.0.1" # Local development environment
      film.locations.each do |location|
        case location.location_type
        when "City"
          return [false, address] if location.city == request_data["city"]
        when "State or Province"
          return [false, address] if location.state_or_province == request_data["region_name"]
        when "Country"
          return [false, address] if location.country == request_data["country_name"]
        end
      end
      return [true, address]
    rescue
      return [false, "Issue with Geoblock - anyone can watch"] # If geoblocking has issues, everyone can watch
    end
  end

  def address(request)
    str = "City: #{request['city'].present? ? request['city'] : 'Unknown'}"
    str += ", Region: #{request['region_name'].present? ? request['region_name'] : 'Unknown'}"
    str += ", Country: #{request['country_name'].present? ? request['country_name'] : 'Unknown'}"
    return str
  end
end