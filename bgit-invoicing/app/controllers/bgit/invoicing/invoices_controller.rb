module Bgit
  module Invoicing
    class InvoicesController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::AasmConcern

      def self.resource_class
        Bgit::Invoicing::Invoice
      end

      def self.available_rest_actions
        super - %i[new create edit update]
      end
    end
  end
end
