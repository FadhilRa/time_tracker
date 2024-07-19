Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session
  resource :registration
  resource :password_reset
  resource :password
  resource :project
  resource :time
  resource :log_task

  get 'projects/:id/tasks', to: 'projects#tasks', as: :project_tasks
  get 'log_tasks/:date/log_list', to: 'log_tasks#log_list', as: :log_list
  get 'log_tasks/:id/edit', to: 'log_tasks#edit', as: :edit_log_tasks
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "main#index"

  post 'create_project', to: 'projects#create', as: :create_project
  post 'create_log_task', to: 'log_tasks#create', as: :create_log_task
  patch 'update_log_task', to: 'log_tasks#update', as: :update_log_task
  patch 'log_tasks/:id/update_timer', to: 'log_tasks#update_timer', as: :update_timer
end
