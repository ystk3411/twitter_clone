# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tweets#index'
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :tasks
  resources :users
  resources :tweets do
    resources :tweets, only: %w[create] 
  end
  
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
