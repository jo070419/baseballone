Rails.application.routes.draw do
  devise_for :users
  root 'recruitments#index'
  get 'pages/show'
  resources :recruitments, except: [:index] do
    resources :applies, only: [:new, :create]
  end
  resources :applies, only: [:index, :show] do
    resources :agreements, only: [:new] do
      collection do
        post 'yes'
        post 'refusal'
      end
    end
  end
  resources :users, only: [:show]
  resources :recruitment_managements, only: [:index]
  resources :agreements, only: [:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
