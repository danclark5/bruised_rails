Rails.application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get 'home/index'
  resources :posts
  resources :sessions

  root 'home#index'
end
