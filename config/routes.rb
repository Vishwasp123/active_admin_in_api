Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :auth, only: [:create]
  resources :users
   get '/users/:email', to: 'users#find_by_email'


  post '/log_in', to: 'auth#create'
  post '/register', to: 'users#create'
  get '/register', to: 'users#new'
  get '/users', to: 'users#index'
  get '/admin', to: 'admin#index'

end
