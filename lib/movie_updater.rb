require "movie_validator"

class MovieUpdater
  def self.execute(movie, attributes)
    new(movie, attributes).execute
  end

  def initialize(movie_id, attributes)
    @movie_id   = movie_id
    @attributes = attributes
  end

  def execute
    update_movie
    save_movie if validation.okay?

    result_of_update
  end

  private

  attr_reader :movie_id, :attributes

  def update_movie
    movie.assign_attributes(attributes)
  end

  def save_movie
    movie.save
  end

  def result_of_update
    Update.new(movie, validation.messages)
  end

  def movie
    @movie ||= Movie.find(movie_id)
  end

  def validation
    @validation ||= MovieValidator.validate(movie)
  end

  class Update
    attr_reader :movie, :messages

    def initialize(movie, messages)
      @movie    = movie
      @messages = messages
    end

    def successful?
      messages.empty?
    end
  end
end
