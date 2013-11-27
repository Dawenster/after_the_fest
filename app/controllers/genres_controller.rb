class GenresController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:show]

  def show
    @genre = Genre.find_by_name(params[:type])
    @films = @genre.films
  end

  def admin_index
    @genres = Genre.order("lower(name) ASC")
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(params)
    if @genre.save
      flash[:success] = "#{@genre.name} has been successfully created."
      redirect_to admin_genres_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "new"
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.assign_attributes(params)
    if @genre.save
      flash[:success] = "#{@genre.name} has been successfully updated."
      redirect_to admin_genres_path
    else
      flash.now[:warning] = "Gawd. Fill everything in correctly man."
      render "edit"
    end
  end

  def destroy
    genre = Genre.find(params[:id]).destroy
    flash[:success] = "#{genre.name} has been deleted."
    redirect_to admin_genres_path
  end
end