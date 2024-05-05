module Bgit
  module Accounting
    module Accounting
      class AccountsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::Account
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:accounting_account).permit(
            :parent_id,
            :keepr_group_id,
            :keepr_tax_id,
            :accountable_type,
            :accountable_id,
            :kind,
            :number,
            :name
          )
        end
      end
    end
  end
end
