Bgit::FrontendAuth::Api::Engine.routes.draw do
  resources :users, only: [] do
    get :current, on: :collection, action: :current
    post "/", on: :collection, action: :create, conditions: ->(req) { Bgit::FrontendAuth::Api::Configuration.enable_registrations }
  end

  resources :sessions, only: [:create]
  
  # post "/users", to: "users#create", conditions: ->(req) { Bgit::FrontendAuth::Api::Configuration.enable_registrations }
  # get "/profile", to: "users#profile"
  # post "/login", to: "authentication#login"
end
