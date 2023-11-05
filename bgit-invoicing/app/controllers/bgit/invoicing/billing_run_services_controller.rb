module Bgit
  module Invoicing
    class BillingRunServicesController < Cmor::Core::Backend::ServiceController::Base
      def self.service_class
        Bgit::Invoicing::BillingRunService
      end

      private

      def permitted_params
        params.require(:billing_run_service).permit(:year, :month)
      end
    end
  end
end
