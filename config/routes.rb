Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  resources :products
  resources :providers
  resources :categories
  resources :shopping_carts, only: :show

  scope module: 'authentication' do
    resources :registration, except: [:index, :new] do  
    end
    resources :session, only: [:create, :destroy]
    get '/confirm_email/:id', to: 'confirm#confirm_email', as: 'confirm_email'

    get '/forgot_password', to: 'forgot_password#forgot_password', as: 'forgot_password'
    post 'send_mail', to: 'forgot_password#send_mail'
    get '/new_password/:id', to: 'forgot_password#new_password', as: 'new_password'
    post '/new_password/:id', to: 'forgot_password#create_new_password'
      
    get "/login", to: "session#new"
    get "/registrations", to: "registration#new"
  end

  post 'add_to_cart', to: 'shopping_carts#add_to_cart'
  post 'remove_from_cart', to: 'shopping_carts#remove_from_cart'
  post 'clear_cart', to: 'shopping_carts#clear_cart'
  
  get 'new_attr_category', to: 'categories#new_attr'
  get 'attrs_list', to: 'products#attrs_list'
  get 'new_attr_product', to: 'products#new_attr'
  post 'new_attr_provider', to: 'providers#new_attr'
  get 'test_remote', to: 'products#test_remote'
  get 'test_doc', to: 'products#test_doc'
end
