module Bgit
  module Lexoffice
    class Contact::ReadServicesController < Cmor::Core::Backend::ServiceController::Base
      def self.service_class
        LexofficeClient::Contact::ReadService
      end

      def self.engine_class
        Bgit::Lexoffice::Engine
      end

      private

      def permitted_params
        params.require(:contact_read_service).permit(:contact_id)
      end
    end
  end
end
