module Bgit
  module Accounting
    module Vouchers
      class BulkUploadServicesController < Cmor::Core::Backend::ServiceController::Base
        include ActiveStorage::SetCurrent

        def self.service_class
          Bgit::Accounting::Vouchers::BulkUploadService
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
          params.fetch(:vouchers_bulk_upload_service, {}).permit(
            assets: []
          )
        end
      end
    end
  end
end
