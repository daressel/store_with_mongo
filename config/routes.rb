Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  resources :products
  resources :providers
  resources :categories

  get 'new_attr_category' => 'categories#new_attr'
  post 'new_attr_product' => 'products#new_attr'
  post 'new_attr_provider' => 'providers#new_attr'
  get 'test_doc' => 'products#test_doc'
end
