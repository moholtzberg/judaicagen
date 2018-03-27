Rails.application.routes.draw do

  get 'items/:id', to: 'items#show'
  authenticate :user do
    resources 'items'
    post 'pay', to: 'payments#create', as: :pay
    get 'my_listings', to: 'items#my_listings'
  end
  
  devise_for :users, :controllers => {:sessions => 'sessions', :registrations => 'registrations'}
  
  get 'listing/new', to: 'items#new', as: :new_listing
  post 'listing/create', to: 'items#create', as: :create_listing
  
  get 'tags/:tag', to: 'items#index', as: :tag
  get "location/:location", to: "items#index", as: :location
  get "family/:family", to: "items#index", as: :family
  get "owner/:owner", to: 'items#index', as: :owner
  get "/" => "items#index", as: :home
  
end