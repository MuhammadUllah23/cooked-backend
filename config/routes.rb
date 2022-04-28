Rails.application.routes.draw do
  resources :products
  resources :users, only: [:create]
  post '/login', to: 'auht#create'
  get '/profile', to: 'users#profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
