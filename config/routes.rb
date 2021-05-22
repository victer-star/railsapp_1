Rails.application.routes.draw do
  get 'likes/index'
  get 'notifications/index'
  root 'static_pages#home'
  get :about,        to: 'static_pages#about'
  get :use_of_terms, to: 'static_pages#terms'
  get :signup,       to: 'users#new'
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  get    :favorites, to: 'favorites#index'
  post   "favorites/:training_id/create"  => "favorites#create"
  delete "favorites/:training_id/destroy" => "favorites#destroy"
  get    :lists,     to: 'lists#index'
  post   "lists/:training_id/create"  => "lists#create"
  delete "lists/:list_id/destroy" => "lists#destroy"
  get   :likes,      to: 'likes#index'
  post   "likes/:training_id/create" => "likes#create"
  delete "likes/:like_id" => "likes#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :trainings
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :records, only: [:new, :create, :edit, :update, :index, :destroy]
end
