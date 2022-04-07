# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post :auth, to: 'auth#login'
      get :auth, to: 'auth#session'

      resources :users
      resources :email_verifications, only: :show

      resources :projects do
        resources :sprints
      end
    end
  end

  root 'home#index'
  get '*path', to: 'home#index'
end
