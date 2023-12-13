Bgit::Invoicing::Engine.routes.draw do
  resources :invoices do
    post "trigger_event/:machine_name/:event_name", on: :member, action: "trigger_event", as: :trigger_event
    get :autocomplete, on: :collection
  end
  resources :line_items

  root to: "home#index"
end
