# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root to: 'records#index'
  resources :users, only: %i[new create index edit update destroy]
  resources :invitations, only: %i[new create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :records, only: %i[new create index show edit update destroy] do
    collection do
      get :search_google
      get :select
      get :search
      get :edit_search_google
      get :edit_select
      delete :destroy_book
    end
  end
  resources :books, only: %i[new create index destroy] do
    collection do
      get :search_google
      get :select
      get :search
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
