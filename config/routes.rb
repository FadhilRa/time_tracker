Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session
  resource :registration
  resource :password_reset
  resource :password
  resources :projects
  resource :time
  resource :log_task
  resource :user

  get 'projects/:id/tasks', to: 'projects#tasks', as: :project_tasks
  get 'log_tasks/:date/log_list', to: 'log_tasks#log_list', as: :log_list
  get 'log_tasks/:id', to: 'log_tasks#log_task_by_id', as: :log_tasks_by_id

  root "log_tasks#show"

  post 'create_project', to: 'projects#create', as: :create_project
  post 'create_log_task', to: 'log_tasks#create', as: :create_log_task
  patch 'log_tasks/:id', to: 'log_tasks#update', as: :update_log_task
  patch 'log_tasks/:id/update_timer', to: 'log_tasks#update_timer', as: :update_timer

  delete 'projects/:id', to: 'projects#destroy', as: :delete_project
  delete 'log_tasks/:id', to: 'log_tasks#destroy', as: :delete_log_task
end
