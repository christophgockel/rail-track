class MovieValidator
  def self.validate(movie)
    new(movie).validate
  end

  def initialize(movie)
    @movie = movie
  end

  def validate
    result = Result.new
    result << validate_title
    result << validate_has_release_date
    result << validate_release_date
    result
  end

  private

  attr_reader :movie

  def validate_title
    "Title can't be empty." if title_empty?
  end

  def validate_has_release_date
    "Release date can't be empty." if release_date_empty?
  end

  def validate_release_date
    return if release_date_empty?
    "Release date is before the world's first motion picture." if release_date_before_1895?
  end

  def title_empty?
    movie.title.blank?
  end

  def release_date_empty?
    movie.release_date.nil?
  end

  def release_date_before_1895?
    movie.release_date.year < 1895
  end

  class Result
    attr_reader :messages

    def initialize
      @messages = []
    end

    def okay?
      messages.empty?
    end

    def <<(message)
      @messages << message if message
    end
  end
end
