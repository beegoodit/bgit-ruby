Bgit::Invoicing::Engine.routes.draw do
  resources :invoices, only: [:index, :show, :destroy] do
    post "trigger_event/:machine_name/:event_name", on: :member, action: "trigger_event", as: :trigger_event
    get :autocomplete, on: :collection
  end
  resources :line_items, only: [:index, :show, :destroy]
  resources :products
  resources :resources
  resources :subscriptions
  resources :tiers do
    post :reposition, on: :member
  end

  resource :billing_run_services, only: [:new, :create]
  resource :generate_invoice_for_owner_services, only: [:new, :create]

  root to: "home#index"
end
