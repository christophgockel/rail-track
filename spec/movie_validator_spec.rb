require "rails_helper"
require "movie_validator"

RSpec.describe MovieValidator do
  let(:valid_movie)   {Movie.new(title: "the title", release_date: DateTime.parse("08 June 1984"))}
  let(:invalid_movie) {Movie.new}

  it "validates a movie" do
    expect(MovieValidator.valid?(valid_movie)).to be_truthy
  end

  it "does not validate movies with missing data" do
    expect(MovieValidator.valid?(invalid_movie)).to be_falsy
  end
end
