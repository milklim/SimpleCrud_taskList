Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names:
      {
          sign_in: 'login',
          sign_out: 'logout',
          password: 'secret',
          confirmation: 'verification',
          unlock: 'unblock',
          registration: 'register',
          sign_up: 'cmon_let_me_in'
      }
  root to: "tasks#index"

  put 'application/locale/:locale', to: 'application#locale', as: "set_locale"

  get '/', to:'tasks#index'
  # resources :tasks do
  #   get 'create', to: 'tasks#new'
  #   post 'create', to: 'tasks#create'
  # end
  get 'tasks/new', to: 'tasks#new', as:'new_task'
  get 'tasks/edit', to: 'tasks#edit', as:'edit_task'
  post 'tasks/new', to: 'tasks#create', as:'create_task'
  patch 'tasks/update/:id', to: 'tasks#update', as: 'update_task'
  delete 'tasks/delete/:id', to: 'tasks#delete', as: 'delete_task'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
