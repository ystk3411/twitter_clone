# frozen_string_literal: true

Rails.application.routes.draw do
  get 'tweets/index'
  get 'tweets/show'
  devise_for :users
  resources :tasks
  resource :tweets
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
