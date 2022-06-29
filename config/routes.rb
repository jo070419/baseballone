Rails.application.routes.draw do
  devise_for :users
  root 'recruitments#index'
  get 'pages/show'
  resources :recruitments, only: [:new, :create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
