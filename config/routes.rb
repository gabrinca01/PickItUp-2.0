Rails.application.routes.draw do
  #get 'home/index'
  root 'home#index'
  devise_for :users
  get "/home", to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
