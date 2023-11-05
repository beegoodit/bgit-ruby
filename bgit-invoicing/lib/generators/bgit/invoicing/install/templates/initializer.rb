Bgit::Invoicing.configure do |config|
  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Bgit::Invoicing::ProductsController,
  #            Bgit::Invoicing::ResourcesController,
  #            Bgit::Invoicing::SubscriptionsController,
  #            Bgit::Invoicing::TiersController,
  #            Bgit::Invoicing::InvoicesController,
  #            Bgit::Invoicing::LineItemsController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Bgit::Invoicing::ProductsController,
      Bgit::Invoicing::ResourcesController,
      Bgit::Invoicing::SubscriptionsController,
      Bgit::Invoicing::TiersController,
      Bgit::Invoicing::InvoicesController,
      Bgit::Invoicing::LineItemsController
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
  #            Bgit::Invoicing::BillingRunServicesController,
  #            Bgit::Invoicing::GenerateInvoiceForOwnerServicesController
  #          ]}
  #
  config.service_controllers = -> {
    [
      Bgit::Invoicing::BillingRunServicesController,
      Bgit::Invoicing::GenerateInvoiceForOwnerServicesController
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

  # Set the resource owner autocomplete options.
  #
  # Default: config.resource_owner_autocomplete_classes = -> { {} }
  #
  config.resource_owner_autocomplete_classes = -> { {} }

  # Set the factory name for the invoice owner.
  #
  # Default: config.resource_owner_factory_name = :<%= invoice_owner_factory_name %>
  #
  config.invoice_owner_factory_name = :<%= invoice_owner_factory_name %>

  # Set the factory name for the resource owner.
  #
  # Default: config.resource_owner_factory_name = :<%= resource_owner_factory_name %>
  #
  config.resource_owner_factory_name = :<%= resource_owner_factory_name %>

  # Set the default currency.
  #
  # Default: config.default_currency = :eur
  #
  config.default_currency = :eur

  # Set the accounting services classes.
  #
  # Default: config.accounting_services_classes = {
  #            invoices: {
  #              create: "Bgit::Lexoffice::Invoice::CreateService",
  #              delete: "Bgit::Lexoffice::Invoice::DeleteService"
  #            }
  #
  config.accounting_services_classes = {
    invoices: {
      create: "Bgit::Lexoffice::Invoice::CreateService",
      delete: "Bgit::Lexoffice::Invoice::DeleteService"
    }
  }
end
