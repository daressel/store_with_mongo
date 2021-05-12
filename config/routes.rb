Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  resources :products
  resources :providers
  # get 'categories/:name', to: 'categories#show', as: :category
  resources :categories

  scope module: 'authentication' do
    resources :registration, except: [:index, :new] do
      member do
        get :confirm_email
      end
    end
    resources :session, only: [:create, :destroy]
    get "/login", to: "session#new"
    get "/registrations", to: "registration#new"
  end


  get 'new_attr_category', to: 'categories#new_attr'
  get 'attrs_list', to: 'products#attrs_list'
  get 'new_attr_product', to: 'products#new_attr'
  post 'new_attr_provider', to: 'providers#new_attr'
  get 'test_remote', to: 'products#test_remote'
  get 'test_doc', to: 'products#test_doc'
end
