Healthpost::Application.routes.draw do
  resources :hospitals


  resources :providers


  resources :practices


  resources :requests


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end