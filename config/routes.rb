# frozen_string_literal: true

Rails.application.routes.draw do
  post 'signin', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  resources :ideas
end
