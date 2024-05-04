Bgit::Accounting::Engine.routes.draw do
  namespace :accounting do
    resources :accounts
    resources :chart_report_services, only: [:new, :create]
    resources :cost_centers
    resources :journals
    resources :groups
    resources :postings
    resources :taxes
  end

  namespace :banking do
    resources :accounts
    resources :import_n26_statements_services, only: [:new, :create]
    resources :transfers
  end

  namespace :contacts do
    resources :addresses
    resources :companies
    resources :contact_people
    resources :contacts do
      get :autocomplete, on: :collection
    end
    resources :email_addresses
    resources :people
    resources :phone_numbers
  end

  namespace :vouchers do
    resources :assign_voucher_services, only: [:new, :create]
    resources :bulk_upload_services, only: [:new, :create]
    resources :create_services, only: [:new, :create]
    resources :vouchers do
      post :destroy_many, on: :collection
    end
  end

  resources :seed_services, only: [:new, :create]

  root to: "home#index"
end
