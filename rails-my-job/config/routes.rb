Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#main'

  get '/calendar', to: 'pages#calendar', as: :calendar

  resources :jobs
  resources :goods
  resources :registers
end
