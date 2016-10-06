class MoviesController < ApplicationController
  def index
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to root_path, notice: "Successfully created movie #{@movie.title}."
    else
      flash.now[:alert] = @movie.errors.full_messages
      render :new
    end
  end

  def edit
    @movie = Movie.find(movie_id)
  end

  def update
    @movie = Movie.find(movie_id)

    if @movie.update_attributes(movie_params)
      redirect_to root_path, notice: "Successfully updated movie #{@movie.title}."
    else
      flash.now[:alert] = @movie.errors.full_messages
      render :edit
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:id, :title, :release_date, :description)
  end

  def movie_id
    params[:id]
  end
end
