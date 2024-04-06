module Bgit
  module Accounting
    module Banking
      class TransfersController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Banking::Transfer
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def load_collection_scope
          super.joins(:recipient_bank_account, :sender_bank_account).order(value_at: :desc)
        end

        def permitted_params
          params.require(:banking_transfer).permit(
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
end
