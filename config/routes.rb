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
    resources :messages, except: [:index, :new, :create, :destroy, :edit, :update, :show] do
      collection do
        post 'apply_show_message'
        post 'agreement_message'
      end
    end
  end
  resources :users, only: [:show]
  resources :recruitment_managements, only: [:index]
  resources :agreements, except: [:index, :new, :create, :destroy, :edit, :update] do
    collection do
      get 'agreement_recruitment'
      get 'agreement_apply'
    end
    member do
      get 'cancel_confirmation'
      get 'cancel_complete'
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
