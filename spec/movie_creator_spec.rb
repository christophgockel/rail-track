require "rails_helper"
require "movie_creator"

RSpec.describe MovieCreator do
  describe "successful creation" do
    let(:movie_attributes) {{
      title:        "the title",
      release_date: Date.today,
      description:  "the description"
    }}

    it "creates a movie" do
      described_class.execute(movie_attributes)

      movie = Movie.first

      expect(Movie.count).to eq(1)
      expect(movie.title).to eq(movie_attributes[:title])
      expect(movie.release_date).to eq(movie_attributes[:release_date])
      expect(movie.description).to eq(movie_attributes[:description])
    end

    it "returns a successful creation" do
      creation = described_class.execute(movie_attributes)

      expect(creation).to be_successful
      expect(creation.movie).to eq(Movie.first)
      expect(creation.messages).to be_empty
    end
  end

  describe "nonsuccessful creation" do
    let(:movie_attributes) {{
      title: ""
    }}

    it "does not create a movie" do
      described_class.execute(movie_attributes)

      expect(Movie.all).to be_empty
    end

    it "returns a nonsuccesful creation" do
      result = described_class.execute(movie_attributes)

      expect(result).not_to be_successful
      expect(result.movie).to be_a(Movie)
      expect(result.messages).not_to be_empty
    end
  end
end
