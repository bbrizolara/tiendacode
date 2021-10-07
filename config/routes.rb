# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :products
  resources :users, except: %i[destroy update edit]
  resources :sessions, only: %i[new create destroy]
  resources :account_activations, only: %i[edit]
  resources :errors, only: %i[show]
  get "/404", to: "errors#not_found"
  get "/500", to: "errors#internal_error"
end
