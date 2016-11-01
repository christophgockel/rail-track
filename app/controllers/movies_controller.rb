require "movies/creator"
require "movies/presenter"
require "movies/updater"

class MoviesController < ApplicationController
  def index
    @movies = Movie.all.map {|movie| Movies::Presenter.new(movie)}
  end

  def new
    @movie = Movie.new
  end

  def create
    creation = Movies::Creator.execute(movie_params)

    if creation.successful?
      redirect_to root_path, notice: "Successfully created movie #{creation.movie.title}."
    else
      @movie = creation.movie
      flash.now[:alert] = creation.messages
      render :new
    end
  end

  def edit
    @movie = Movie.find(movie_id)
  end

  def update
    update = Movies::Updater.execute(movie_id, movie_params)

    if update.successful?
      redirect_to root_path, notice: "Successfully updated movie #{update.movie.title}."
    else
      @movie = update.movie
      flash.now[:alert] = update.messages
      render :edit
    end
  end

  def show
    @movie = Movies::Presenter.new(Movie.find(movie_id))
  end

  private

  def movie_params
    params.require(:movie).permit(:id, :title, :release_date, :description)
  end

  def movie_id
    params[:id]
  end
end
