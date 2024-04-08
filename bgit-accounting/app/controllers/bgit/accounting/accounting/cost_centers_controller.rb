module Bgit
  module Accounting
    module Accounting
      class CostCentersController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::CostCenter
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:accounting_cost_center).permit(:number, :name, :note)
        end
      end
    end
  end
end
