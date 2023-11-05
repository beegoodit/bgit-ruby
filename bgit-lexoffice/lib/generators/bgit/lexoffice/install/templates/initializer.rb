Bgit::Lexoffice.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.register_engine("Bgit::Lexoffice::Engine", {})
  #
  config.cmor.administrador.register_engine("Bgit::Lexoffice::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Bgit::Lexoffice::ContactsController,
  #            Bgit::Lexoffice::InvoicesController,
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Bgit::Lexoffice::ContactsController,
      Bgit::Lexoffice::InvoicesController
    ]
  }

  # Set the singular resources, that will be shown in the backend menu.
  #
  # Default: config.resource_controllers = -> {[
  #          ]}
  #
  config.resource_controllers = -> {
    []
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[
  #            Bgit::Lexoffice::Contact::ReadServicesController
  #          ]}
  #
  config.service_controllers = -> {
    [
      Bgit::Lexoffice::Contact::ReadServicesController
    ]
  }

  # Set the sidebars, that will be shown in the backend menu.
  #
  # Default: config.sidebar_controllers = -> {[
  #          ]}
  #
  config.sidebar_controllers = -> {
    []
  }

  # Set the autocomplete classes for contact contactables.
  #
  # Default: config.contact_contactable_autocomplete_classes = -> { {
  #            Bgit::FrontendAuth::User => bgit_frontend_auth.url_for([:autocomplete, Bgit::FrontendAuth::User])
  #          } }
  #
  config.contact_contactable_autocomplete_classes = -> {
    {
      Bgit::FrontendAuth::User => bgit_frontend_auth.url_for([:autocomplete, Bgit::FrontendAuth::User])
    }
  }

  # Set the autocomplete classes for invoice invoiceables.
  #
  # Default: config.invoice_invoiceable_autocomplete_classes = -> { {} }
  #
  config.invoice_invoiceable_autocomplete_classes = -> { {} }
end
