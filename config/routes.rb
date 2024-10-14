Rails.application.routes.draw do
  root "stories#index"

  get "about", to: "profile#index"
  get "profile", to: "profile#profile"
  
  resources :todos do
    member do
      post :complete
      patch :toggle
    end
  end

  resources :stories do
    member do
      post :upvote
    end
  end

  resources :tasks do
    collection do
      get :all
    end    
  end
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

end
