Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resources :user_only_groups, path: :my_groups
    resources :user_only_tournaments, path: :my_tournaments
  end

  # get '/dashboard', to: 'users#show'

  # get '/dashboard/edit', to: 'users#edit'

  get '/signup', to: 'users#new'

  post '/signup', to: "users#create"

  resources :account_activations, only: [:edit]

  resources :groups

  resources :group_users

  resources :messages, only: [:create]

  resources :tournaments, only: [:create, :new, :show]

  resources :group_user_tournaments

  resources :bets

end
