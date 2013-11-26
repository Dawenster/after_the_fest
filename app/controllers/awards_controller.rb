class AwardsController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_NAME'], :password => ENV['ADMIN_PASSWORD'], :except => [:index]

  def index
    @awards = Award.order("lower(name) ASC")
  end

  def admin_index
    @awards = Award.order("lower(name) ASC")
  end

  def new
    @award = Award.new
  end

  def create
    @award = Award.new(award_params)
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
    @award.assign_attributes(award_params)
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

  private

  def award_params
    params.require(:award).permit(:name, :image, :film_ids => [])
  end
end