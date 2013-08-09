Auction::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  resources :products, :only => [:index, :show] do
    member do
      match "ask", :via => :post
    end
  end
  
  resources :users, :only => [:show] do
    member do
      get "products"
      get "deals"
    end
  end

  resources :deals, :only => [:create] do
    collection do
      match "/new", :via => :post
      match "check", :via => :post
      get "finish"
    end
  end

  namespace :useradmin do
    resources :products, :except => [:new] do
      member do
        match 'uploadPhoto' => 'products#createPhoto', :via => [:post]
        match 'deletePhoto/:photo_id' => 'products#destroyPhoto', :via => [:delete]

        match "enable", :via => :post
        match "disable", :via => :post
      end
    end
    
    resources :productasks, :only => [:index, :show] do
      member do
        match "reply", :via => :post
      end
    end
    resources :myasks, :only => [:index, :show]

    resources :deals, :only => [:index, :show] do
      member do
        match "createask", :via => :post
        get "dealvalues"
        match "createvalue", :via => :post
      end

      namespace :changestatus do
        match "check", :via => :post
        match "processing", :via => :post
        match "deliver", :via => :post
        match "cancel", :via => :post
      end
    end
    resources :buyrecords, :only => [:index, :show] do
      member do
        match "createask", :via => :post
        get "dealvalues"
        match "createvalue", :via => :post
      end

      namespace :changestatus do
        match "check", :via => :post
        match "processing", :via => :post
        match "deliver", :via => :post
        match "cancel", :via => :post
      end
    end

    resources :users, :only => [] do
      collection do
        get "aboutme"
        get "aboutme/edit" => "users#aboutme_edit"
        match "aboutme/update" => "users#aboutme_update", :via => :put

        match 'aboutme/uploadPhoto' => 'users#createPhoto', :via => [:post]
        match 'aboutme/deletePhoto/:id' => 'users#destroyPhoto', :via => [:delete]

        resources :blacklists, :only => [:index, :create, :destroy]
      end
    end

    root :to => "root#index"
  end

  namespace :admin do
    get "login", "logout"
    match "checkAdmin", :via => :post

    resources :users, :only => [:index, :show]

    resources :products, :only => [:index, :show] do
      member do
        match "enable", :via => :post
        match "disable", :via => :post
      end
    end

    resources :productclasses do
      member do
        get "select"
      end
    end

    root :to => "users#index"
  end

  root :to => "products#index"
end
