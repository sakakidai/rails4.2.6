require 'sidekiq/web'

Rails.application.routes.draw do
  resources :articles
  root to: 'dashboard#index'
  get 'dashboard/index'

  mount Sidekiq::Web, at: "/sidekiq"
end
