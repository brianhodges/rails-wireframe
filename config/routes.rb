Rails.application.routes.draw do
  resources :users
  resources :roles
  resources :sessions, :only => [:create]
  
  #Needed for Login/Authentication
  get 'register' => 'users#new', :as => 'register'
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  
  root :to => 'sessions#home', :as => :home
end
