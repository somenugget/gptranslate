Rails.application.routes.draw do
  root 'translations#index'
  get 't/*path', to: 'translations#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get :auth, to: 'auth#index'

  authenticate :user, ->(user) { user.email == ENV['ADMIN_EMAIL'] } do
    mount GoodJob::Engine => '/good_job'
  end

  resources :translations

  namespace :api do
    resources :translations, only: %i[index show create update destroy] do
      resources :phrases, only: %i[index]
    end

    resources :phrases, only: %i[create update destroy] do
      member do
        post :retry
      end
    end
  end
end
