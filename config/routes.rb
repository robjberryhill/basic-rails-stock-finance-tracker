Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]

  devise_for :users

  devise_scope :user do
    get "friends", to: "users#my_friends"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "welcome#index"

  get "my_portfolio", to: "users#my_portfolio"
  get "search_friends", to: "users#search_friends"
  get "search_stock", to: "stocks#search"
  resources :users, only: [:show]
end
