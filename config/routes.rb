Rails.application.routes.draw do
  root to: "projects#index"

  get    '/login'     => 'sessions#new'
  post   '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:new, :create]

  resources :projects, only: [:index, :show]
  get 'projects/:slug' => 'projects#show'

  namespace :admin do
    resources :projects, param: :slug do
      resources :projects_users, only: [:index, :create, :destroy], path: 'assignments', param: :user_id
      resources :tasks, shallow: true do
        resource :task_performer, only: [:create, :destroy]
        member do
          get :summary
        end
      end
    end
  end
end
