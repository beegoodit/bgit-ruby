module Bgit
  module Accounting
    module Vouchers
      class CreateServicesController < Cmor::Core::Backend::ServiceController::Base
        def self.service_class
          Bgit::Accounting::Vouchers::CreateService
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.fetch(:vouchers_create_service, {}).permit()
        end
      end
    end
  end
end
