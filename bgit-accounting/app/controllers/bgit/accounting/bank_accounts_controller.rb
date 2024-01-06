module Bgit
  module Accounting
    class BankAccountsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Accounting::BankAccount
      end

      private

      def permitted_params
        params.require(:bank_account).permit(
          :accountable_id,
          :accountable_type,
          :active_from,
          :active_to,
          :iban,
          :name,
          :owner
        )
      end
    end
  end
end
