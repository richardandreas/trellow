Rails.application.routes.draw do
  get 'auth/login'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
