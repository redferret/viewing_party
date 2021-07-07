Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope module: :users do
    resource :dashboard, only: :show
    resource :register, controller: :users, only: [:new, :create]
    resource :login, controller: :sessions, only: :create
    resource :logout, controller: :sessions, only: :destroy
  end

  post '/dashboard', to: 'users/dashboards#show'
  # get '/users', to: 'users/dashboards#show'


end
