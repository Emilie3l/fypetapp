Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/myreports', to: 'pages#myreports'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets, only: [:create, :new] do
    resources :reports, only: [:create, :new]
  end
  resources :reports, only: [:index, :show, :update, :edit, :destroy]
end
