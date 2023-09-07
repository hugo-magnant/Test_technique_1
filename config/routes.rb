Rails.application.routes.draw do
  root "users#new"
  resources :users, only: [:create, :new]
end
