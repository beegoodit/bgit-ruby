module Bgit
  module Invoicing
    class InvoicesController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::AasmConcern

      def self.resource_class
        Bgit::Invoicing::Invoice
      end

      # def self.available_rest_actions
      #   super - %i[new create edit update]
      # end

      private

      def permitted_params
        params.require(:invoice).permit(:owner_type, :owner_id, :year, :month)
      end
    end
  end
end
