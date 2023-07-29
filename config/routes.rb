Rails.application.routes.draw do
  root 'translations#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get :auth, to: 'auth#index'

  # mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  resources :translations
end
