Rails.application.routes.draw do
  root to: "projects#index"

  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create]

  resources :projects, only: [:index, :show]
  get 'projects/:slug' => 'projects#show'

  namespace :admin do
    resources :projects, except: [:show]
    get 'projects/:slug' => 'projects#show'
  end
end
