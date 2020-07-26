Rails.application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get 'home/index'
  get 'home/:page' => "home#page", :as => "page"
  resources :posts
  resources :sessions

  root 'home#index'
end
