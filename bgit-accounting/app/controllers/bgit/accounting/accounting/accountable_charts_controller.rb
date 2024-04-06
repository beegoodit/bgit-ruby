module Bgit
  module Accounting
    module Accounting
      class AccountableChartsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::AccountableChart
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.require(:accounting_accountable_chart).permit(:accountable_id, :accountable_type, :chart_id, :active_from, :active_to)
        end
      end
    end
  end
end
