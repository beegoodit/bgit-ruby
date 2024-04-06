module Bgit
  module Accounting
    module Banking
      class AccountsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Banking::Account
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.require(:banking_account).permit(
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
end
