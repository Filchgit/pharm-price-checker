Rails.application.routes.draw do
  get 'stock_items/index'
  get 'stock_items/new'
  get 'stock_items/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'stock_items/index'
  resources :stock_items, only: [:index, :create, :new ] do
  end
end
