require "movie_validator"

class MoviesController < ApplicationController
  def index
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    validation = validate(@movie)

    if validation.okay?
      @movie.save
      redirect_to root_path, notice: "Successfully created movie #{@movie.title}."
    else
      flash.now[:alert] = validation.messages
      render :new
    end
  end

  def edit
    @movie = Movie.find(movie_id)
  end

  def update
    @movie = Movie.find(movie_id)
    @movie.assign_attributes(movie_params)
    validation = validate(@movie)

    if validation.okay?
      @movie.save
      redirect_to root_path, notice: "Successfully updated movie #{@movie.title}."
    else
      flash.now[:alert] = validation.messages
      render :edit
    end
  end

  def show
    @movie = Movie.find(movie_id)
  end

  private

  def movie_params
    params.require(:movie).permit(:id, :title, :release_date, :description)
  end

  def movie_id
    params[:id]
  end

  def validate(movie)
    MovieValidator.validate(movie)
  end
end
