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

          define_singleton_method("#{key}=") do |value|
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
                                                         Bgit::Accounting::AccountsController,
                                                         Bgit::Accounting::CostCentersController,
                                                         Bgit::Accounting::GroupsController,
                                                         Bgit::Accounting::JournalsController,
                                                         Bgit::Accounting::PostingsController,
                                                         Bgit::Accounting::TaxesController,
                                                         Bgit::Accounting::BankAccountsController,
                                                         Bgit::Accounting::TransfersController
                                                       ]
                                                     }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> { [Bgit::Accounting::ImportN26StatementsServicesController] }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :accountable_classes, default: -> { {} }
      define_option :accountable_factory_name, default: :user
    end
  end
end
