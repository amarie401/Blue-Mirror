Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create', as: 'signin'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'auth/failure', to: redirect('/')
  get 'auth/current', to: 'sessions#current'
  get 'todos/featured', to: 'todos#featured'
  get 'inspos', to: 'inspos#index'
  patch 'mood_lists', to: 'mood_lists#update'
  patch 'users/phone', to: 'phone#update'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  resources :users
  resources :todos, only: [:index, :show, :create, :destroy]
  resources :moods, only: [:index, :create]
  resources :notes
  resources :events
  resources :meds

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
