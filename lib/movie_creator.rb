require "movie_validator"
require "result"

class MovieCreator
  def self.execute(attributes)
    new(attributes).execute
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def execute
    create_movie
    save_movie if validation.okay?

    result_of_create
  end

  private

  attr_reader :attributes, :movie

  def create_movie
    @movie ||= Movie.new(attributes)
  end

  def save_movie
    movie.save
  end

  def result_of_create
    Result.new(movie, validation.messages)
  end

  def validation
    @validation ||= MovieValidator.validate(movie)
  end
end
