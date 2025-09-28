Rails.application.routes.draw do
  # Deviseのルーティング
  devise_for :users

  # 静的ページのルーティング
  root 'static_pages#home'

  # リソースのルーティング
  resources :users, only: [:index, :show] # ユーザーの作成はDeviseが担当
  resources :posts

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
