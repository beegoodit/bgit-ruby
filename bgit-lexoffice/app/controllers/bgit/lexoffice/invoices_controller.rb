module Bgit
  module Lexoffice
    class InvoicesController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Lexoffice::Invoice
      end

      def self.available_rest_actions
        super - %i[new create]
      end

      private

      def permitted_params
        params.require(:invoice).permit(:lexoffice_id, :invoiceable_id, :invoiceable_type)
      end
    end
  end
end
