Rails.application.routes.draw do
  get 'sessions/new'
  root "static_pages#home"
  get '/zones',             to: 'static_pages#zones'
  get '/how',               to: 'static_pages#how'
  get '/about',             to: 'static_pages#about'
  get '/contact',           to: 'static_pages#contact'
  get '/feed',              to: 'static_pages#feed'
  get '/signup',            to: 'users#new'
  get '/login',             to: 'sessions#new'
  post '/login',            to: 'sessions#create'
  delete '/logout',         to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :orders, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
