Rails.application.routes.draw do

  get 'sessions/new'

  get    'signup'  =>    'users#new'
  get    'home'    =>    'static_pages#home'
  get    'contact' =>    'static_pages#contact'
  get    'help'    =>    'static_pages#help'
  get    'about'   =>    'static_pages#about'
  get    'login'   =>    'sessions#new'
  post   'login'   =>    'sessions#create'
  delete 'logout'  =>    'sessions#destroy'

  root 'static_pages#home'
  
  resources :users
  resources :account_activations, only: [:edit]
end
