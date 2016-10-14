require "rails_helper"
require "movie_presenter"

RSpec.describe MoviePresenter do
  it "has an id" do
    movie = Movie.new
    presenter = described_class.new(movie)

    expect(presenter.id).to eq(movie.id)
  end

  it "titleizes the title" do
    movie = Movie.new(title: "the movie title")
    presenter = described_class.new(movie)

    expect(presenter.title).to eq("The Movie Title")
  end

  it "formats the release date" do
    movie = Movie.new(release_date: Date.parse("1984-06-08"))
    presenter = described_class.new(movie)

    expect(presenter.release_date).to eq("8 June 1984")
  end

  it "presents the description" do
    movie = Movie.new(description: "the description")
    presenter = described_class.new(movie)

    expect(presenter.description).to eq(movie.description)
  end
end
