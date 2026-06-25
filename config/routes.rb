Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker

  resource :session
  get "offline", to: "static_pages#offline", as: :offline

  resources :notes, except: %i[new show]

  get "preferences", to: "preferences#edit", as: :preferences
  patch "preferences", to: "preferences#update"

  root "notes#index"
end
