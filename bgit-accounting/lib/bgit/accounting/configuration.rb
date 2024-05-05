module Bgit
  module Accounting
    class Configuration
      class << self
        extend Forwardable

        attr_accessor :values

        def define_option(key, default: nil)
          @values[key] = default
          define_singleton_method(key) do
            @values[key]
          end

          define_singleton_method(:"#{key}=") do |value|
            @values[key] = value
          end
        end

        def cmor
          Cmor
        end
      end

      @values = {}

      define_option :resources_controllers, default: -> {
                                                       [
                                                         Bgit::Accounting::Accounting::AccountsController,
                                                         Bgit::Accounting::Accounting::CostCentersController,
                                                         Bgit::Accounting::Accounting::GroupsController,
                                                         Bgit::Accounting::Accounting::GroupsController,
                                                         Bgit::Accounting::Accounting::JournalsController,
                                                         Bgit::Accounting::Accounting::PostingsController,
                                                         Bgit::Accounting::Accounting::TaxesController,
                                                         Bgit::Accounting::Banking::AccountsController,
                                                         Bgit::Accounting::Banking::TransfersController
                                                       ]
                                                     }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> {
                                                     [
                                                       Bgit::Accounting::ImportN26StatementsServicesController,
                                                       Bgit::Accounting::SeedServicesController
                                                     ]
                                                   }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :accountable_classes, default: -> { {} }
      define_option :accountable_factory_name, default: :user
    end
  end
end
