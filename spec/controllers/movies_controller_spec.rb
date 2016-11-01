require "rails_helper"
require "movies/presenter"

RSpec.describe MoviesController do
  describe "#index" do
    render_views

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "has a list of movies" do
      get :index
      expect(assigns(:movies)).to be_an(Array)
    end

    it "wraps the movies in a presenter" do
      movie = Movie.create!(title: "title", release_date: Date.today)
      get :index
      expect(assigns(:movies).first).to be_a(Movies::Presenter)
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    render_views

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

      expect(Movie).to exist
    end

    it "does not create a new movie with validation errors" do
      create_movie(title: "")

      expect(Movie).not_to exist
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

  describe "#edit" do
    let(:movie) {Movie.create!(title: "title", release_date: Date.today)}

    it "renders the edit template" do
      get :edit, id: movie.id
      expect(response).to render_template("edit")
    end

    it "finds the movie to edit" do
      get :edit, id: movie.id
      expect(assigns(:movie)).to be_truthy
    end
  end

  describe "#update" do
    render_views

    let(:movie) {Movie.create!(title: "old title", release_date: Date.today)}

    def update_movie(attributes = {})
      patch :update, id: movie.id, movie: {
        "title":        "title",
        "release_date": "2016-01-01",
        "description":  "description"
      }.merge(attributes)
    end

    it "redirects to movie overview" do
      update_movie(id: movie.id)
      expect(response).to redirect_to(root_path)
    end

    it "contains a success message" do
      update_movie(id: movie.id, title: "new title")
      expect(flash[:notice]).to include("updated movie new title")
    end

    it "updates a movie" do
      update_movie(id: movie.id,
                   title: "updated title",
                   release_date: Date.parse("1984-06-08"),
                   description: "updated description")

      expect(movie.reload.title).to eq("updated title")
    end

    it "does not update a movie with validation errors" do
      update_movie(id: movie.id,
                   title: "")

      expect(movie.reload.title).not_to eq("")
    end

    it "re-renders the form again on errors" do
      update_movie(id: movie.id, title: "")
      expect(response).to render_template("edit")
    end

    it "contains an error message for invalid movies" do
      update_movie(id: movie.id, title: "")
      expect(flash.now[:alert].first).to include("Title")
    end
  end

  describe "#show" do
    let(:movie) {Movie.create!(title: "title", release_date: Date.today)}

    it "renders the show template" do
      get :show, id: movie.id
      expect(response).to render_template("show")
    end

    it "wraps a movie in a presenter" do
      get :show, id: movie.id
      expect(assigns(:movie)).to be_a(Movies::Presenter)
    end
  end
end
