Auction::Application.routes.draw do
  devise_for :users

  resources :products, :only => [:index, :show] do
    member do
      match "ask", :via => :post
    end
  end
  
  resources :users, :only => [:show] do
    member do
      get "products"
      get "orders"
    end
  end

  namespace :useradmin do
    resources :products do
      resources :stocks, :only => [:index, :create, :destroy] do
        collection do
          match "updateStocks", :via => :post
        end
      end
    end
    
    resources :productasks, :only => [:index, :show] do
      member do
        match "reply", :via => :post
      end
    end
    resources :myasks, :only => [:index]

    root :to => "products#index"
  end

  root :to => "products#index"
end
