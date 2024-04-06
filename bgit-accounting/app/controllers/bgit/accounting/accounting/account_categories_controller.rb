module Bgit
  module Accounting
    module Accounting
      class AccountCategoriesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::AccountCategory
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.require(:accounting_account_category).permit
        end
      end
    end
  end
end
