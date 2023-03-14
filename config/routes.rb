Rails.application.routes.draw do
  
  get 'profilepage/index'
  get 'leaderboard/index'
  get 'map/index'
  root 'home#index'
  get "/home", to: "home#index"
  get "/home/search", to: "home#search"
  devise_scope :user do
     get 'verify', to: 'users/registrations#verify', as: 'verify'
     post 'verify', to: 'users/registrations#verify'
     get 'users/sign_out', to: 'devise/sessions#destroy'
     
  end
  resources :follows
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
