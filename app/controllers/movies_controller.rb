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

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :description)
  end
end
