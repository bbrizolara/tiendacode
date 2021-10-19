# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :products do
    resources :questions, only: %i[create]
  end
  resources :users, except: %i[destroy update edit]
  resources :sessions, only: %i[new create destroy]
  namespace :activation do
    resources :accounts, only: %i[edit]
  end  
  resources :errors, only: %i[show]
  get "/404", to: "errors#not_found"
  get "/500", to: "errors#internal_error"
end
