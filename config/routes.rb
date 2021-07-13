Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'root'

  scope module: :users do
    get '/discover', to: 'movies#index'
    post '/movies', to: 'movies#index'
    resource :dashboard, only: :show
    resource :friendship, only: [:create, :destroy]
    resources :movies, only: :show
    resource :login, controller: :sessions, only: :create
    resource :logout, controller: :sessions, only: :destroy
    resource :movie_party, only: [:new, :create]
  end
  
  resource :register, controller: :users, only: [:new, :create]
end
