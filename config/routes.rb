Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope module: :users do
    resource :dashboard, only: [:show, :create]
    get '/discover', to: 'movies#index'
    resources :movies, only: :show
    post '/movies', to: 'movies#index'
    resource :register, controller: :users, only: [:new, :create]
    resource :login, controller: :sessions, only: :create
    resource :logout, controller: :sessions, only: :destroy
    resource :movie_party, only: [:new, :create]
  end

  post '/dashboard', to: 'users/dashboards#show'
end
