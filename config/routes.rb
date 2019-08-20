Rails.application.routes.draw do
  root to: "projects#index"

  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create]
  resources :projects, only: [:index]

  namespace :admin do
    resources :projects
  end
end
