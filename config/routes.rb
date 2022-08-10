Rails.application.routes.draw do

  #### ORIGINAL CODE
  #root "products#index"

  #delete '/products/:id', to: 'products#destroy'
  #patch '/products/:id', to: 'products#update'
  #post '/products', to: 'products#create'
  #get '/products/new', to: 'products#new', as: :new_product
  #get '/products', to: 'products#index'
  #get '/products/:id', to: 'products#show', as: :product
  #get '/products/:id/edit', to: 'products#edit', as: :edit_product  

  #### REFACTOR V1
  #root "products#index"
  #resources :products # Genera todas las rutas anteriores


  #### REFACTOR V2
  #resources :products, path: "/" # Es equivalente a las dos líneas anteriores

  ### Routes

  
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: '/'}
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
  end

  resources :categories, except: :show
  resources :products, path: '/'
  resources :users, path: '/user', only: :show, param: :username
end
