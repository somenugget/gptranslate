require 'sidekiq/web'

Rails.application.routes.draw do
  root 'translations#index'
  get 't/*path', to: 'translations#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get :auth, to: 'auth#index'

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  resources :translations

  namespace :api do
    resources :translations, only: %i[index show create update destroy]
    resources :phrases, only: %i[create update destroy] do
      member do
        post :retry
      end
    end
  end
end
