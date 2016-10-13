class MoviePresenter
  def initialize(movie)
    @movie = movie
  end

  def title
    movie.title.titleize
  end

  def release_date
    movie.release_date.strftime('%-d %B %Y')
  end

  def description
    movie.description
  end

  private

  attr_reader :movie
end
