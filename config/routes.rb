Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users,
  path: 'users',
  path_names: { sign_in: :login, sign_out: :logout }
  # controllers: {
  #   passwords: 'users/passwords',
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions'
  # }

  root 'stories#index'

  resources :users, only: [:show]

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
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
