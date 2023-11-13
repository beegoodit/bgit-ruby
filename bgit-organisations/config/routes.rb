Bgit::Organisations::Engine.routes.draw do
  resources :teams do
    get :autocomplete, on: :collection
  end
  resources :team_memberships

  root to: "home#index"
end
