Rails.application.routes.draw do
  root "movies#index"

  get   "/movie/new"      => "movies#new",    as: :new_movie
  post  "/movie"          => "movies#create", as: :create_movie
  get   "/movie/edit/:id" => "movies#edit",   as: :edit_movie
  patch "/movie/:id"      => "movies#update", as: :update_movie
end
