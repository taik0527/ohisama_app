Rails.application.routes.draw do
  resources :users, only: %i[index new create edit update destroy]
  resources :sessions, only: %i[new create destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
