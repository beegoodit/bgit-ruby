module Bgit
  module Lexoffice
    class Invoice::ReadServicesController < Cmor::Core::Backend::ServiceController::Base
      def self.service_class
        LexofficeClient::Invoice::ReadService
      end

      def self.engine_class
        Bgit::Lexoffice::Engine
      end

      private

      def permitted_params
        params.require(:invoice_read_service).permit(:invoice_id)
      end
    end
  end
end
