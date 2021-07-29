Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, only: %i[new create index edit update destroy]
  resources :sessions, only: %i[new create destroy]
  resources :invitations, only: %i[new create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
