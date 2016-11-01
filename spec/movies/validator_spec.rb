require "rails_helper"
require "movies/validator"

RSpec.describe Movies::Validator do

  def validation_of(movie)
    described_class.validate(movie)
  end

  context "valid movie" do
    let(:valid_movie) {Movie.new(title: "the title", release_date: DateTime.parse("08 June 1984"))}

    it "is valid" do
      expect(validation_of(valid_movie)).to be_okay
    end

    it "does not return any messages" do
      expect(validation_of(valid_movie).messages).to be_empty
    end
  end

  context "invalid movie" do
    let(:invalid_movie) {Movie.new}

    it "is not valid" do
      expect(validation_of(invalid_movie)).not_to be_okay
    end

    it "does return validation messages" do
      expect(validation_of(invalid_movie).messages).not_to be_empty
    end

    it "validates the title" do
      expect(validation_of(invalid_movie).messages).to include("Title can't be empty.")
    end

    it "validates the release date" do
      expect(validation_of(invalid_movie).messages).to include("Release date can't be empty.")
    end

    it "validates that the release date is > 1895" do
      invalid_movie.release_date = Date.parse("1500-01-01")
      expect(validation_of(invalid_movie).messages).to include("Release date is before the world's first motion picture.")
    end
  end
end
