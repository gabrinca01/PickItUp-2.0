Rails.application.routes.draw do
  get 'profilepage/index'
  get 'news/index'
  get 'leaderboard/index'
  get 'sponsors/index'
  get 'settings/index'
  get 'challenges/index'
  get 'map/index'
  root 'home#index'
  devise_for :users
  get "/home", to: "home#index"
  
end
