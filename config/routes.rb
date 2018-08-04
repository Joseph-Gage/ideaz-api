# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/sign-in', to: 'authentication#authenticate'
  post 'sign-up', to: 'users#create'
  resources :ideas
end
