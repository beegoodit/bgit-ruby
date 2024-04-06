module Bgit
  module Accounting
    module Vouchers
      class AssignVoucherServicesController < Cmor::Core::Backend::ServiceController::Base
        include ActiveStorage::SetCurrent

        def self.service_class
          Bgit::Accounting::Vouchers::AssignVoucherService
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
          params.fetch(:vouchers_assign_voucher_service, {}).permit(
            :description,
            :due_date,
            :type,
            :voucher_date,
            :voucher_id,
            :voucher_number,
            amounts: [
              :net_amount,
              :tax_amount,
              :tax_rate_percentage,
              :account_id
            ]
          )
        end
      end
    end
  end
end
