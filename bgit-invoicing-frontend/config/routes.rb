Bgit::Invoicing::Frontend::Engine.routes.draw do
  localized do
    scope :bgit_invoicing_frontend_engine do
      resources :invoices, only: [:index, :show]
      root to: "home#index"
    end
  end
end
