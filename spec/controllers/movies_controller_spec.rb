require "rails_helper"

RSpec.describe MoviesController do
  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    def create_movie(attributes = {})
      post :create, movie: {
        "title":        "new movie",
        "release_date": "2016-10-01",
        "description":  "new description"
      }.merge(attributes)
    end

    it "redirects to movie overview" do
      create_movie
      expect(response).to redirect_to(root_path)
    end

    it "contains a success message" do
      create_movie
      expect(flash[:notice]).to include("created movie new movie")
    end

    it "creates a new movie" do
      create_movie

      newest_movie = Movie.last

      expect(newest_movie.title).to eq("new movie")
      expect(newest_movie.release_date).to eq(Date.parse("2016-10-01"))
      expect(newest_movie.description).to eq("new description")
    end

    it "does not create a new movie with validation errors" do
      create_movie(title: "")

      expect(Movie.all).to be_empty
    end

    it "re-renders the form again on errors" do
      create_movie(title: "")
      expect(response).to render_template("new")
    end

    it "contains an error message for invalid movies" do
      create_movie(title: "")
      expect(flash.now[:alert].first).to include("Title")
    end
  end
end
