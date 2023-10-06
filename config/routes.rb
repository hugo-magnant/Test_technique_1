Rails.application.routes.draw do
  root "users#new"

  resources :users, only: [:create, :new]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
    end
  end
end
