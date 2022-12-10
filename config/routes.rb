Rails.application.routes.draw do
  resources :articles
  root to: 'dashboard#index'
  get 'dashboard/index'
end
