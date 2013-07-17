Auction::Application.routes.draw do
  devise_for :users

  resources :products, :only => [:index, :show]
  resources :users, :only => [:show] do
    member do
      get "products"
      get "orders"
    end
  end

  namespace :useradmin do
    resources :products

    root :to => "products#index"
  end

  root :to => "products#index"
end
