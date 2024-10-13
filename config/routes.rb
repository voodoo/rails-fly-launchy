Rails.application.routes.draw do
  get "about", to: "profile#index"
  get "profile", to: "profile#profile"
  resources :stories do
    member do
      post :upvote
    end
  end

  root "stories#index"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker"

  # Defines the root path route ("/")
  # root "posts#index"

  resources :tasks do
    collection do
      get :all
    end    
    member do
      patch :collapse
      patch :uncollapse
    end
  end
end
