Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get '/signup',   to: 'users#new'
  get '/login',    to: 'sessions#new'
  get '/users/blocklist', to: 'users#blocklist', as: 'blocklist'
  post '/users/reblock', to: 'users#reblock', as: 'reblock'
  post '/login',   to: 'sessions#create'
  delete'/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :notifications
      post :block
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :votes,               only: [:create]
  mount ActionCable.server => '/cable'
end
