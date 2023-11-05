module Bgit
  module Invoicing
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
      end

      @values = {}

      define_option :resources_controllers, default: -> {
                                                       [
                                                         Bgit::Invoicing::ProductsController,
                                                         Bgit::Invoicing::ResourcesController,
                                                         Bgit::Invoicing::SubscriptionsController,
                                                         Bgit::Invoicing::TiersController,
                                                         Bgit::Invoicing::InvoicesController,
                                                         Bgit::Invoicing::LineItemsController
                                                       ]
                                                     }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> {
                                                     [
                                                       Bgit::Invoicing::BillingRunServicesController,
                                                       Bgit::Invoicing::GenerateInvoiceForOwnerServicesController
                                                     ]
                                                   }
      define_option :sidebar_controllers, default: -> { [] }
      define_option :resource_owner_factory_name, default: :user
      define_option :invoice_owner_factory_name, default: :user
      define_option :resource_owner_autocomplete_classes, default: -> { {} }
      define_option :default_currency, default: :eur
      define_option :accounting_services_classes, default: {
        invoices: {
          create: "Bgit::Lexoffice::Invoice::CreateService",
          delete: "Bgit::Lexoffice::Invoice::DeleteService"
        }
      }
    end
  end
end
