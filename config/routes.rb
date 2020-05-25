Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users,
  path: 'users',
  path_names: { sign_in: :login, sign_out: :logout }
  # controllers: {
  #   confirmations: 'users/confirmations',
  #   passwords: 'users/passwords',
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions'
  # }

  get 'stories/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
