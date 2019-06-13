Rails.application.routes.draw do
  get '/admin/import', to: 'import#index'
  post '/admin/import', to: 'import#import'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :products
  devise_for :stores, controllers: { registrations: 'stores/registrations' }

  root 'marketplace#index'
  get '/', to: 'marketplace#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
