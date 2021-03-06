# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :auth, to: 'auth#login'
      get :auth, to: 'auth#user'

      resources :users

      resources :projects do
        resources :sprints
      end
    end
  end

  root 'home#index'
  get '*path', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
