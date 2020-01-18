Rails.application.routes.draw do
  get 'home/index'
  resources :posts
  root 'home#index'
end
