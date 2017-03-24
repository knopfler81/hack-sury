Rails.application.routes.draw do

  get 'payments/create'

  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'home#show'

  resources :users, only: [:show] do
    post 'send_message'
  end

  # rajouter avec pundit les problematiques d'authentifications (white list...).
  resources :trips do
    post 'send_message_to_driver'
    resources :bookings, only: [:new, :create]
    resources :destinations, only: [:create]
    resources :steps, only: [:create, :edit, :update, :destroy]
    resources :reviews, only: [:create]
  end

  resources :destinations, only: [:show, :index]

  resources :bookings, only: [:update, :show, :edit] do
    resources :payments, only: [:create]
  end

  resources :notifications, only: [:show]

  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
