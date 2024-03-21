module Bgit
  module Accounting
    class TransfersController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Accounting::Transfer
      end

      private

      def permitted_params
        params.require(:transfer).permit(
          :amount,
          :purpose,
          :recipient_bank_account_id,
          :sender_bank_account_id,
          :transaction_at,
          :value_at
        )
      end
    end
  end
end
