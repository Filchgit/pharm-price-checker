Rails.application.routes.draw do
  devise_for :users

  get 'pharmacy_stock_items/index'
  get 'pharmacy_stock_items/compare'
  get 'stock_items/index'
  get 'stock_items/new'
  get 'stock_items/create'
  get 'stock_apns', to: 'stock_apns#download'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  root to: 'stock_items#index'

  # Sidekiq Web UI, only for admins.
  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :stock_items, only: [:index, :create, :new, :edit, :update] do
    collection { post :upload }
    collection { post :csv_upload }
  end

  resources :pharmacy_stock_items, only: [:index, :create, :new, :edit, :update, :compare ] do
    collection { post :upload }
    collection { post :gst_upload }
  end

  resources :settings, only: [:create, :new, :edit, :update]
end
