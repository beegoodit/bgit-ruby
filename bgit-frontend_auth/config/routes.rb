Bgit::FrontendAuth::Engine.routes.draw do
  resources :users do
    get :autocomplete, on: :collection
  end

  root to: "home#index"
end
