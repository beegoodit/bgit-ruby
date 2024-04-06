module Bgit
  module Accounting
    module Banking
      class ImportN26StatementsServicesController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          Bgit::Accounting::Banking::ImportN26StatementsService
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def initialize_service
          super
          @service.assign_attributes(permitted_params)
        end

        def permitted_params
          params.require(:banking_import_n26_statements_service).permit(:account_id, :csv_file)
        end
      end
    end
  end
end
