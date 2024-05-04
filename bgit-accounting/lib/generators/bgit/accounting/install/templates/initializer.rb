Bgit::Accounting.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.register_engine("Bgit::Accounting::Engine", {})
  #
  config.cmor.administrador.register_engine("Bgit::Accounting::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Bgit::Accounting::Accounting::AccountsController,
  #            Bgit::Accounting::Accounting::CostCentersController,
  #            Bgit::Accounting::Accounting::GroupsController,
  #            Bgit::Accounting::Accounting::JournalsController,
  #            Bgit::Accounting::Accounting::PostingsController,
  #            Bgit::Accounting::Accounting::TaxesController,
  #            Bgit::Accounting::Contacts::AddressesController,
  #            Bgit::Accounting::Contacts::CompaniesController,
  #            Bgit::Accounting::Contacts::ContactPeopleController,
  #            Bgit::Accounting::Contacts::ContactsController,
  #            Bgit::Accounting::Contacts::EmailAddressesController,
  #            Bgit::Accounting::Contacts::PhoneNumbersController,
  #            Bgit::Accounting::Banking::AccountsController,
  #            Bgit::Accounting::Banking::TransfersController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Bgit::Accounting::Accounting::AccountsController,
      Bgit::Accounting::Accounting::CostCentersController,
      Bgit::Accounting::Accounting::GroupsController,
      Bgit::Accounting::Accounting::JournalsController,
      Bgit::Accounting::Accounting::PostingsController,
      Bgit::Accounting::Accounting::TaxesController,
      Bgit::Accounting::Contacts::AddressesController,
      Bgit::Accounting::Contacts::CompaniesController,
      Bgit::Accounting::Contacts::ContactPeopleController,
      Bgit::Accounting::Contacts::ContactsController,
      Bgit::Accounting::Contacts::EmailAddressesController,
      Bgit::Accounting::Contacts::PhoneNumbersController,
      Bgit::Accounting::Banking::AccountsController,
      Bgit::Accounting::Banking::TransfersController,
      Bgit::Accounting::Vouchers::VouchersController
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
  #            Bgit::Accounting::Accounting::ChartReportServicesController,
  #            Bgit::Accounting::Banking::ImportN26StatementsServicesController,
  #            Bgit::Accounting::SeedServicesController,
  #            Bgit::Accounting::Vouchers::AssignVoucherServicesController,
  #            Bgit::Accounting::Vouchers::BulkUploadServicesController,
  #            Bgit::Accounting::Vouchers::CreateServicesController
  #          ]}
  #
  config.service_controllers = -> {
    [
      Bgit::Accounting::Accounting::ChartReportServicesController,
      Bgit::Accounting::Banking::ImportN26StatementsServicesController,
      Bgit::Accounting::SeedServicesController,
      Bgit::Accounting::Vouchers::AssignVoucherServicesController,
      Bgit::Accounting::Vouchers::BulkUploadServicesController,
      Bgit::Accounting::Vouchers::CreateServicesController,
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

  # Set the account owner classes with their respective autocomplete url.
  #
  # Default: config.accountable_classes = -> {
  #            {
  #              User => main_app.url_for([:autocomplete, User]),
  #              Bgit::Accounting::Contacts::Contact => bgit_accounting.url_for([:autocomplete, Bgit::Accounting::Contacts::Contact])
  #            }
  #          }
  #
  config.accountable_classes = -> {
    {
      User => main_app.url_for([:autocomplete, User]),
      Bgit::Accounting::Contacts::Contact => bgit_accounting.url_for([:autocomplete, Bgit::Accounting::Contacts::Contact])
    }
  }

  # Set the bank account owner factory name.
  #
  # Default: config.accountable_factory_name = :user
  #
  config.accountable_factory_name = :user
end
