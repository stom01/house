Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'residents#index'

  resources :residents
  resources :chores

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: "sessions#destroy"

end
