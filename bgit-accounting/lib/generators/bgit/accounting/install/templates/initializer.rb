Bgit::Accounting.configure do |config|
  # Register self to be shown in the backend.
  #
  # Default: config.register_engine("Bgit::Accounting::Engine", {})
  #
  config.cmor.administrador.register_engine("Bgit::Accounting::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Bgit::Accounting::AccountsController,
  #            Bgit::Accounting::CostCentersController,
  #            Bgit::Accounting::GroupsController,
  #            Bgit::Accounting::JournalsController,
  #            Bgit::Accounting::PostingsController,
  #            Bgit::Accounting::TaxesController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Bgit::Accounting::AccountsController,
      Bgit::Accounting::CostCentersController,
      Bgit::Accounting::GroupsController,
      Bgit::Accounting::JournalsController,
      Bgit::Accounting::PostingsController,
      Bgit::Accounting::TaxesController
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
  #          ]}
  #
  config.service_controllers = -> {
    []
  }

  # Set the sidebars, that will be shown in the backend menu.
  #
  # Default: config.sidebar_controllers = -> {[
  #          ]}
  #
  config.sidebar_controllers = -> {
    []
  }
end
