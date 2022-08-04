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
  resources :categories, except: :show
  resources :products, path: '/'
  
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create]
  end

end
