Rails.application.routes.draw do
  get 'appointments', to: 'appointments#new'

  get    '/adminsignup',  to: 'admins#new'
  get    '/adminlogin', to: 'adminsession#new'
  post   '/adminlogin', to: 'adminsession#create'
  delete '/adminlogout',  to: 'adminsession#destroy'

  get 'suits/new',   to: 'suits#new'

  get 'suits/index', to: 'suits#index'

  get 'suits/show',  to: 'suits#show'

  get 'suits/edit',  to: 'suits#edit'

  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'session#new'
  post   '/login',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'
  resources :users, :suits, :admins
end
