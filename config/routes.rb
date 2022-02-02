Rails.application.routes.draw do
  root   'home#index'
  get    'edit'    => 'home#edit'
  post   'edit'    => 'home#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'signup'  => 'users#new'
  post   'signup'  => 'users#create'

  get    'preview' => 'profiles#preview'
  get    'show/:id'=> 'profiles#show'

  resources :profiles
  resources :educations
  resources :experiences
  resources :projects
  resources :users
end
