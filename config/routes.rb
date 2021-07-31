Rails.application.routes.draw do
  root to: 'records#index'
  resources :users, only: %i[new create index edit update destroy]
  resources :invitations, only: %i[new create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :records, only: %i[new create index show edit update destroy]
  resources :books, only: %i[new create index destroy] do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
