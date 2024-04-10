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

  namespace :contacts do
    resources :addresses
    resources :companies
    resources :contact_people
    resources :contacts
    resources :email_addresses
    resources :phone_numbers
    resources :emails
  end

  resources :import_n26_statements_services, only: [:new, :create]
  resources :seed_services, only: [:new, :create]

  root to: "home#index"
end
