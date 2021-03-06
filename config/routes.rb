Rails.application.routes.draw do
  root to: "sessions#new"

  get    '/login'     => 'sessions#new'
  post   '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users

  get 'journal' => 'journal#index'

  resources :projects, param: :slug do
    resources :projects_users, only: [:index, :create, :destroy], path: 'assignments', param: :user_id
    resources :comments, only: [:create, :index]
    resources :tasks, shallow: true do
      resources :comments, only: [:create, :index]
      resources :time_logs, only: [:create, :destroy, :index]
      resource :task_performer, only: [:create, :destroy]
      member do
        get :summary
      end
    end
  end
end
