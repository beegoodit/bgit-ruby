module Bgit
  module Accounting
    module Accounting
      class AccountsController < Cmor::Core::Backend::ResourcesController::Base
        include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern

        def self.resource_class
          Bgit::Accounting::Accounting::Account
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.require(:accounting_account).permit(
            :account_category_id,
            :accountable_type,
            :accountable_id,
            :account_number,
            :label
          )
        end
      end
    end
  end
end
