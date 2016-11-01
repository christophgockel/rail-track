require "movies/validator"
require "movies/result"

module Movies
  class Updater
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
      Result.new(movie, validation.messages)
    end

    def movie
      @movie ||= Movie.find(movie_id)
    end

    def validation
      @validation ||= Validator.validate(movie)
    end
  end
end
