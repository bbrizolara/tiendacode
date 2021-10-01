# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  resources :products
  resources :users, except: %i[destroy update edit]
  resources :sessions, only: %i[new create destroy]
  resources :unauthorized, only: %i[index]
end
