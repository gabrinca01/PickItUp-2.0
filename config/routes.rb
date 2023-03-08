Rails.application.routes.draw do
  resources :roles
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
  end
  
  devise_for :users,controllers: {
        sessions: 'users/sessions',registrations: 'users/registrations'
      }, :controller => { :omniauth_callbacks => "users/omniauth_callbacks" }, :strategy_class => OmniAuth::Strategies::Facebook
end
