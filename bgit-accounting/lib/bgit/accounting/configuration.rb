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
                                                         Bgit::Accounting::Accounting::AccountsController,
                                                         Bgit::Accounting::Banking::AccountsController,
                                                         Bgit::Accounting::Banking::TransfersController,
                                                         Bgit::Accounting::Banking::TransferVouchersController,
                                                         Bgit::Accounting::Vouchers::CategoriesController,
                                                         Bgit::Accounting::Vouchers::ExpenditureCategoriesController,
                                                         Bgit::Accounting::Vouchers::VouchersController,
                                                         Bgit::Accounting::Vouchers::PurchaseInvoicesController
                                                       ]
                                                     }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> {
                                                     [
                                                       Bgit::Accounting::Banking::AssignTransferServicesController,
                                                       Bgit::Accounting::Banking::ImportN26StatementsServicesController,
                                                       Bgit::Accounting::Vouchers::AssignVoucherServicesController
                                                     ]
                                                   }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :accountable_classes, default: -> { {} }
      define_option :accountable_factory_name, default: :user
    end
  end
end
