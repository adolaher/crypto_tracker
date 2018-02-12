Rails.application.routes.draw do
  root 'coins#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :coins
    resources :prices
  end



  resources :coins do

    resources :comments
  end

  resources :users
end
