Bgit::Accounting::Engine.routes.draw do
  resources :accounts
  resources :cost_centers
  resources :groups
  resources :journals
  resources :postings, only: [:index, :show]
  resources :taxes
  root to: "home#index"
end
