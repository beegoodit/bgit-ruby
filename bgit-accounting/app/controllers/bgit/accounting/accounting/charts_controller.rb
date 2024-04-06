module Bgit
  module Accounting
    module Accounting
      class ChartsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::Chart
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.require(:accounting_chart).permit
        end
      end
    end
  end
end
