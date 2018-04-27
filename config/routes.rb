Rails.application.routes.draw do
  get 'admin_password_resets/new'

  get 'admin_password_resets/edit'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'renters', to: 'renters#index'
  
  #get 'renters/index'

  get 'renters/show'

  get 'renters/new'

  get 'renters/edit'

  get 'appointments', to: 'appointments#index'

  get    '/adminsignup',  to: 'admins#new'
  get    '/adminlogin', to: 'adminsession#new'
  post   '/adminlogin', to: 'adminsession#create'
  delete '/adminlogout',  to: 'adminsession#destroy'

  get 'suits/new',   to: 'suits#new'

  get 'suits/index', to: 'suits#index'

  get 'suits/show',  to: 'suits#show'

  get 'suits/edit',  to: 'suits#edit'

  root   'static_pages#home'
  get    'home',     to:  'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/signup',  to: 'users#new'
  get    '/userinfo',  to: 'users#show'
  get    '/login',   to: 'session#new'
  post   '/login',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'
  resources :users, :suits, :admins, :renters, :appointments, :histories
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :admin_password_resets,     only: [:new, :create, :edit, :update]

  resources :users do
    resources :suits
  end
  
  resources :users do
    member do
      get :confirm_email
    end
  end
  
  resources :admins do
    member do
      get :confirm_email
    end
  end
  
  resources :renters do
    member do
      put :remind
    end
  end
end
