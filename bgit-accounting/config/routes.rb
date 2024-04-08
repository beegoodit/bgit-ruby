Bgit::Accounting::Engine.routes.draw do
  namespace :accounting do
    resources :accounts
    resources :cost_centers
    resources :journals
    resources :groups
    resources :postings, only: [:index, :show]
    resources :taxes
  end

  namespace :banking do
    resources :accounts
    resources :transfers
  end

  resources :import_n26_statements_services, only: [:new, :create]
  resources :seed_services, only: [:new, :create]

  root to: "home#index"
end
