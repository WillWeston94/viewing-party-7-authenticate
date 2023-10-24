Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  resources :users, only: :show

  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'

  resources :sessions, only: %w[new create]

  delete '/logout', to: 'sessions#destroy', as: 'logout'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    get '/users/:id', to: 'users#show', as: 'user'
  end
end
