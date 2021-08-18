Rails.application.routes.draw do
  root to: 'records#index'
  resources :users, only: %i[new create index edit update destroy]
  resources :invitations, only: %i[new create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :records, only: %i[new create index show edit update destroy] do
    collection do
      get :search
      get :select
      get :edit_search
      get :edit_select
      post :date
      post :classroom
      post :manager
      post :body
      post :images
      delete :destroy_book
    end
  end
  resources :books, only: %i[new create index destroy] do
    collection do
      get :search
      get :select
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
