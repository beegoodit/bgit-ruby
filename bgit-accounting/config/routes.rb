Bgit::Accounting::Engine.routes.draw do
  namespace :accounting do
    resources :charts
    resources :account_categories
    resources :accounts do
      get :autocomplete, on: :collection
    end
    resources :accountable_charts
    resources :chart_report_services, only: [:new, :create]
  end

  namespace :banking do
    resources :accounts
    resources :assign_transfer_services, only: [:new, :create]
    resources :import_n26_statements_services, only: [:new, :create]
    resources :transfers
    resources :transfer_vouchers
  end

  namespace :vouchers do
    resources :assign_voucher_services, only: [:new, :create]
    resources :bulk_upload_services, only: [:new, :create]
    resources :amounts
    resources :vouchers
    resources :uncheckeds
  end

  root to: "home#index"
end
