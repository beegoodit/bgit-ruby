module Bgit
  module Accounting
    class ImportN26StatementsServicesController < Cmor::Core::Backend::ServiceController::Base
      def self.service_class
        Bgit::Accounting::ImportN26StatementsService
      end

      private

      def permitted_params
        params.require(:import_n26_statements_service).permit(:account_id, :csv_file)
      end
    end
  end
end
