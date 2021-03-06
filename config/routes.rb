Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  get 'users/show'

  get 'listings', to: 'items#listings'

  resources :reviews

  resources :items, except: :destroy do
    resources :workshop_dates, only: %i[index new create edit update destroy]
    resources :reviews, only: %i[index new create]
    resources :order_items, only: %i[create update]
  end
  resources :order_items, only: [:destroy]

  resources :orders, only: %i[index show] do
    resources :payments, only: :new
  end
  patch '/orders/:id', to: 'orders#confirm', as: 'confirm_order'
  put '/orders/:id', to: 'orders#cancel', as: 'cancel_order'

  delete '/items/:id', to: 'items#destroy', as: 'delete_item'
end
