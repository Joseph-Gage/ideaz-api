# frozen_string_literal: true

Rails.application.routes.draw do
  post 'login', to: 'authentication#authenticate'
  post 'register', to: 'users#create'
  get 'me', to: 'users#me'
  resources :ideas
  resources :votes
end
