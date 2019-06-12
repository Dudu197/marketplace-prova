Rails.application.routes.draw do
  resources :products
  devise_for :stores

  root 'marketplace#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
