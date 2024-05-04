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
            :contact_id,
            :creditor_account_id,
            :debtor_account_id,
            :due_date,
            :issue_date,
            :kind,
            :note,
            :number,
            :voucher_id,
            postings: [
              :keepr_account_id,
              :amount,
              :side
            ]
          )
        end
      end
    end
  end
end
