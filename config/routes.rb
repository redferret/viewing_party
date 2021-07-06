Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope module: :users do
    resource :dashboard, only: :show
  end
  resource :register, controller: :users, only: [:new, :create]
  resource :login, controller: :sessions, only: [:create]
end
