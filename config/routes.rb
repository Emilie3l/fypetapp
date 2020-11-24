Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets, only: [:create, :new] do
    resources :reports, only: [:create, :new, :update, :edit]
  end
  resources :reports, only: [:show, :destroy, :index]
end
