Rails.application.routes.draw do
  
  get 'profilepage/index'
  get 'news/index'
  get 'leaderboard/index'
  get 'sponsors/index'
  get 'settings/index'
  get 'challenges/index'
  get 'map/index'
  root 'home#index'
  get "/home", to: "home#index"
  get "/home/search", to: "home#search"
  devise_scope :user do
     get "/users/sign_out", to: "users/sessions#destroy"
     get "/users/sign_in", to: "users/sessions#new"
  end
  resources :comments
  resources :posts
  resources :challenges
  resources :awards
  resources :join_challenges
  resources :messages
  resources :news


  
  devise_for :users,controllers: {
        sessions: 'users/sessions',registrations: 'users/registrations',omniauth_callbacks:  'users/omniauth_callbacks'}, :strategy_class => OmniAuth::Strategies::Facebook
end
