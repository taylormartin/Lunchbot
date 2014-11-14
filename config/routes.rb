Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]
  resources :restaurants
  resources :reviews

  root to: "home#index"
end
