Rails.application.routes.draw do
  root to: "users#new"

  resources :users, only: [:new, :create]

  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
