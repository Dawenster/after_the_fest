class FilmsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:show]

  def show
    @film = Film.find_by_slug(params[:slug])
    @festival = @film.festival
    @geoblock = geoblock?(@film)
  end

  def admin_index
    @films = Film.order("lower(name) ASC")
  end

  def new
    @film = Film.new
  end

  def create
    params = convert_param_dates
    @film = Film.new(film_params)
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
    @film.assign_attributes(film_params)
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

  def film_params
    params.require(:film).permit(
      :name,
      :embed_url,
      :image,
      :up_votes,
      :down_votes,
      :slug,
      :festival_id, 
      :director,
      :writer,
      :starring,
      :description,
      :run_time,
      :screening,
      :start,
      :end,
      :genre_ids => [],
      :awards_ids => [],
      :location_ids => []
    )
  end

  def convert_param_dates
    params[:film][:start] = convert_to_date_object(params[:film][:start])
    params[:film][:end] = convert_to_date_object(params[:film][:end])
    return params
  end

  def convert_to_date_object(str)
    DateTime.strptime(str, "%m/%d/%Y")
  end

  def geoblock?(film)
    request_data = request.location.data
    return false if film.locations.empty? # No geoblocking set - anyone can watch
    return false if request_data["ip"] == "127.0.0.1" # Local development environment
    film.locations.each do |location|
      case location.location_type
      when "City"
        return false if location.city == request_data["city"]
      when "State or Province"
        return false if location.state_or_province == request_data["region_name"]
      when "Country"
        return false if location.country == request_data["country_name"]
      end
    end
    return true
  end
end