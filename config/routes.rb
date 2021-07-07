Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope module: :users do
    resource :dashboard, only: :show
    resource :discover, controller: :movies, only: :show
    post '/movies', to: 'movies#show'
    resource :register, controller: :users, only: [:new, :create]
    resource :login, controller: :sessions, only: :create
    resource :logout, controller: :sessions, only: :destroy
  end
end
