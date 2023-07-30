require 'sidekiq/web'

Rails.application.routes.draw do
  get 'translation_phrases/create'
  root 'translations#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get :auth, to: 'auth#index'

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  resources :translations
  resources :translation_phrases
end
