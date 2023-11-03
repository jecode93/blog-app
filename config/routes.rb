Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Define root path
  root to: 'users#index'
  
  # MY CODE
  # get '/users', to: "users#index"
  # get '/users/:id', to: "users#show"
  # get '/users/:user_id/posts', to: "posts#index"
  # get '/users/:user_id/posts/:id', to: "posts#show"
  
  #CODE REVIEWER optional comment
  # [OPTIONAL] While this is going to work fine, I will encourage you to take advantage of resources by having something like:
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
  # With this, you have shorter code to write and you keep it simple, stupid.
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
