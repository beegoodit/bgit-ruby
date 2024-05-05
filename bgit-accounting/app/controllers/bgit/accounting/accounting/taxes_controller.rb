module Bgit
  module Accounting
    module Accounting
      class TaxesController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::Tax
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:accounting_tax).permit(:name, :value, :keepr_account_id)
        end
      end
    end
  end
end
