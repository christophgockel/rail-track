require "rails_helper"

RSpec.describe Movie do
  let(:title)        {"The Title"}
  let(:release_date) {Date.parse("2016-01-01")}
  let(:description)  {"The Description"}

  def create_movie(attributes = {})
    Movie.create!({title: title, release_date: release_date, description: description}.merge(attributes))
  end

  it "has a title, release date and description" do
    movie = create_movie

    expect(movie.title).to eq(title)
    expect(movie.release_date).to eq(release_date)
    expect(movie.description).to eq(description)
  end

  it "needs a title" do
    expect { create_movie(title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "needs a release date" do
    expect { create_movie(release_date: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "needs a release date younger than the world's first motion picture" do
    too_old_release_date = Date.parse("1700-01-01")
    expect { create_movie(release_date: too_old_release_date) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
