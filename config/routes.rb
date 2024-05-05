# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root 'tweets#index'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :tasks
  resources :tweets
  resources :users
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
