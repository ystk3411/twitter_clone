# frozen_string_literal: true

Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/show'
  root 'tweets#index'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :tasks
  resources :users
  resources :bookmarks, only: %w[index]
  resources :tweets do
    resources :likes, only: %w[create destroy]
    resources :retweets, only: %w[create destroy]
    resources :tweets, only: %w[create]
    resources :relationships, only: %w[create destroy]
    resources :bookmarks, only: %w[create destroy]
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
