Bgit::Organisations::Frontend::Engine.routes.draw do
  localized do
    scope :bgit_organisations_frontend_engine do
      resources :teams, only: [:index, :show] do
        resources :team_memberships, only: [:index], controller: "teams/team_memberships"
      end
      root to: "home#index"
    end
  end
end
