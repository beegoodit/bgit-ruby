module Bgit
  module Invoicing
    class GenerateInvoiceForOwnerServicesController < Cmor::Core::Backend::ServiceController::Base
      def self.service_class
        Bgit::Invoicing::GenerateInvoiceForOwnerService
      end

      private

      def permitted_params
        params.require(:generate_invoice_for_owner_service).permit(:owner_id, :owner_type, :year, :month)
      end
    end
  end
end
