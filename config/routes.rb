Rails.application.routes.draw do
  
  get 'profilepage/index'
  get 'leaderboard/index'
  get 'map/index'
  root 'home#index'
  get "/home", to: "home#index"
  get "/home/search", to: "home#search"
  devise_scope :user do
     get "/users/sign_out", to: "users/sessions#destroy"
     get "/users/sign_in", to: "users/sessions#new" 
     get 'verify', to: 'users/registrations#verify', as: 'verify'
     post 'verify', to: 'users/registrations#verify'
     post 'sign_up', to: 'devise/registrations#create'
  end
  
  resources :comments
  resources :posts
  resources :challenges
  resources :awards
  resources :join_challenges
  resources :messages
  resources :news
  resources :companies

  

  
  devise_for :users,controllers: {
        registrations: 'users/registrations',omniauth_callbacks:  'users/omniauth_callbacks'}, :strategy_class => OmniAuth::Strategies::Facebook
end
