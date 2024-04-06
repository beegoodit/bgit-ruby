Bgit::Accounting.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.register_engine("Bgit::Accounting::Engine", {})
  #
  config.cmor.administrador.register_engine("Bgit::Accounting::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Bgit::Accounting::Accounting::ChartsController,
  #            Bgit::Accounting::Accounting::AccountableChartsController,
  #            Bgit::Accounting::Accounting::AccountCategoriesController,
  #            Bgit::Accounting::Accounting::AccountsController,
  #            Bgit::Accounting::Banking::AccountsController,
  #            Bgit::Accounting::Banking::TransfersController,
  #            Bgit::Accounting::Banking::TransferVouchersController,
  #            Bgit::Accounting::Vouchers::AmountsController,
  #            Bgit::Accounting::Vouchers::UncheckedsController,
  #            Bgit::Accounting::Vouchers::VouchersController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Bgit::Accounting::Accounting::ChartsController,
      Bgit::Accounting::Accounting::AccountableChartsController,
      Bgit::Accounting::Accounting::AccountCategoriesController,
      Bgit::Accounting::Accounting::AccountsController,
      Bgit::Accounting::Banking::AccountsController,
      Bgit::Accounting::Banking::TransfersController,
      Bgit::Accounting::Banking::TransferVouchersController,
      Bgit::Accounting::Vouchers::AmountsController,
      Bgit::Accounting::Vouchers::UncheckedsController,
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
  #            Bgit::Accounting::Banking::AssignTransferServicesController,
  #            Bgit::Accounting::Banking::ImportN26StatementsServicesController,
  #            Bgit::Accounting::Vouchers::AssignVoucherServicesController,
  #            Bgit::Accounting::Vouchers::BulkUploadServicesController
  #          ]}
  #
  config.service_controllers = -> {
    [
      Bgit::Accounting::Accounting::ChartReportServicesController,
      Bgit::Accounting::Banking::AssignTransferServicesController,
      Bgit::Accounting::Banking::ImportN26StatementsServicesController,
      Bgit::Accounting::Vouchers::AssignVoucherServicesController,
      Bgit::Accounting::Vouchers::BulkUploadServicesController
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
  #              User => main_app.url_for([:autocomplete, User])
  #            }
  #          }
  #
  config.accountable_classes = -> {
    {
      User => main_app.url_for([:autocomplete, User])
    }
  }

  # Set the bank account owner factory name.
  #
  # Default: config.accountable_factory_name = :user
  #
  config.accountable_factory_name = :user
end
