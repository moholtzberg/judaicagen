Rails.application.routes.draw do
  
  authenticate :user do
    scope "/admin" do
      resources :items
    end
    get "my_listings", to: "gallery#my_listings"
  end
  
  devise_for :users, :controllers => {:sessions => 'sessions', :registrations => 'registrations'}
  
  get 'listing/new', to: 'gallery#new', as: :new_listing
  post 'listing/create', to: 'gallery#create', as: :create_listing
  
  get 'tags/:tag', to: 'gallery#index', as: :tag
  get "location/:location", to: "gallery#index", as: :location
  get "family/:family", to: "gallery#index", as: :family
  get "owner/:owner", to: 'gallery#index', as: :owner
  get "/" => "gallery#index", as: :home
  
end