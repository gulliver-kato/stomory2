Rails.application.routes.draw do
  resources :users, only: [:show]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users,
  path: 'users',
  path_names: { sign_in: :login, sign_out: :logout }

  resources :stories do
    collection do
      post :confirm
      get :mystory
    end
  end

  resources :parts do
    collection do
      post :confirm
    end
  end
  root 'stories#index'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
