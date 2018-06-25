# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/signin', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
