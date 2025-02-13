Rails.application.routes.draw do
  get "orders/edit"
  devise_for :users
  resources :menus do
    resources :orders, only: %i[create edit update], shallow: true
  end
  root "menus#index"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
