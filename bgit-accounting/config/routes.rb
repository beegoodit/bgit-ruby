Bgit::Accounting::Engine.routes.draw do
  resources :accounts
  resources :cost_centers
  resources :groups
  resources :journals
  resources :postings, only: [:index, :show]
  resources :taxes
  resources :bank_accounts
  resources :transfers

  resources :import_n26_statements_services, only: [:new, :create]

  root to: "home#index"
end
