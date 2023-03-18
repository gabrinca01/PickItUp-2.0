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
     get 'sign_in', to: 'devise/sessions#new'
     post 'sign_in',to: 'devise/sessions#create'
     get 'users/sign_out',to: 'devise/sessions#destroy'
  end
  resources :follows
  resources :comments
  resources :posts
  resources :challenges do 
    resources :messages
  end
  resources :awards
  resources :join_challenges
  resources :news
  resources :companies

  

  
  devise_for :users,controllers: {
        registrations: 'users/registrations',omniauth_callbacks:  'users/omniauth_callbacks'}, :strategy_class => OmniAuth::Strategies::Facebook
end
