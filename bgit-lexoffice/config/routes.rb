Bgit::Lexoffice::Engine.routes.draw do
  resources :contacts, constraints: {id: /\d+/}
  resources :invoices, constraints: {id: /\d+/}, only: [:index, :show, :destroy, :edit, :update] do
    namespace :document do
      resource :read_services, only: [:new, :create]

      # This is a hack to get the download button working as we can't seem to
      # be able to disable turbolinks for the download button.
      #
      # See: app/views/bgit/lexoffice/invoices/_show_table.html.haml
      #
      get "download", to: "read_services#create"
    end
  end

  namespace :contact do
    resources :read_services, only: [:new, :create]
  end

  namespace :invoice do
    resources :read_services, only: [:new, :create]
  end

  root to: "home#index"
end
