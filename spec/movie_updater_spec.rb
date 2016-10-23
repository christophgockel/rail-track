require "rails_helper"
require "movie_updater"

RSpec.describe MovieUpdater do
  let(:movie) {Movie.create(title: "the title",
                            release_date: Date.today,
                            description: "the description")}

  describe "successful update" do
    let(:new_attributes) {{
      title:        "new title",
      release_date: Date.parse("1984-06-08"),
      description:  "new description"
    }}

    it "updates a movie" do
      described_class.execute(movie.id, new_attributes)

      movie = Movie.first

      expect(movie.title).to eq(new_attributes[:title])
      expect(movie.release_date).to eq(new_attributes[:release_date])
      expect(movie.description).to eq(new_attributes[:description])
    end

    it "returns a successful update" do
      update = described_class.execute(movie.id, new_attributes)

      expect(update).to be_successful
      expect(update.movie).to eq(Movie.first)
      expect(update.messages).to be_empty
    end
  end

  describe "nonsuccessful update" do
    let(:new_attributes) {{
      title: ""
    }}

    it "does not update the movie" do
      described_class.execute(movie.id, new_attributes)

      expect(movie.reload.title).to eq("the title")
    end

    it "returns a nonsuccesful update" do
      result = described_class.execute(movie.id, new_attributes)

      expect(result).not_to be_successful
      expect(result.movie).to be_a(Movie)
      expect(result.messages).not_to be_empty
    end
  end
end
