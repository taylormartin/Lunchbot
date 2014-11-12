Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]
  resources :restaurant
  resources :review

  root to: "home#index"
end
