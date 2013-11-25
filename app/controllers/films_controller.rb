class FilmsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:show]

  def show
    @film = Film.find_by_slug(params[:slug])
    @festival = @film.festival
    @request_data = request.location.data
  end

  def admin_index
    @films = Film.all
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
end