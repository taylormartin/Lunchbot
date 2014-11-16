Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]
  resources :restaurants
  resources :reviews

  post '/visited', to: 'restaurants#visited', as: 'visited'
  get  '/new_spot', to: 'home#new_spot', as: 'new_spot'

  root to: "home#index"
end