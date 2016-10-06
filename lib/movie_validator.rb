class MovieValidator
  def self.valid?(movie)
    new(movie).valid?
  end

  def initialize(movie)
    @movie = movie
  end

  def valid?
    has_title? && has_valid_release_date?
  end

  private

  attr_reader :movie

  def has_title?
    movie.title.present?
  end

  def has_valid_release_date?
    has_release_date? && release_date_not_before_1895?
  end

  def has_release_date?
    !movie.release_date.nil?
  end

  def release_date_not_before_1895?
    movie.release_date.year >= 1895
  end
end
