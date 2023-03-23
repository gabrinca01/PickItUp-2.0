Rails.application.routes.draw do
  
  get 'profilepage/index'
  get 'leaderboard/index'
  get 'map/index'
  root 'home#index'
  get "/home", to: "home#index"
  get "/home/search", to: "home#search"
  get "posts/to_verify", to: "posts#to_verify"
  post "posts/verify",to: "posts#verify"
  devise_scope :user do
     get 'verify', to: 'users/registrations#verify', as: 'verify'
     post 'verify', to: 'users/registrations#verify'
     get 'sign_in', to: 'devise/sessions#new'
     post 'sign_in',to: 'devise/sessions#create'
     get 'users/sign_out',to: 'devise/sessions#destroy'
  end
  resources :follows
  resources :posts do 
    resources :comments
    resources :likes
  end
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
