Rottenpotatoes::Application.routes.draw do
  get '/movies/similar/:id' => "movies#similar", :as => 'movies_similar'
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
