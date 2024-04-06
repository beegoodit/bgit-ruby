module Bgit
  module Accounting
    module Banking
      class TransferVouchersController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Banking::TransferVoucher
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def load_collection_scope
          super.joins(:transfer, :voucher, :sender_bank_account, :recipient_bank_account)
        end

        def permitted_params
          params.require(:banking_transfer_voucher).permit
        end
      end
    end
  end
end
