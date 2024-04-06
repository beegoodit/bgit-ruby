module Bgit
  module Accounting
    module Banking
      class AssignTransferServicesController < Cmor::Core::Backend::ServiceController::Base
        include ActiveStorage::SetCurrent

        def self.service_class
          Bgit::Accounting::Banking::AssignTransferService
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
          params.fetch(:banking_assign_transfer_service, {}).permit(:transfer_id, transfer_vouchers: [:id])
        end
      end
    end
  end
end
