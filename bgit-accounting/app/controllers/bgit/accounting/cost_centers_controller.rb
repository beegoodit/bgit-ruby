module Bgit
  module Accounting
    class CostCentersController < Cmor::Core::Backend::ResourcesController::Base
      include Bgit::Accounting::Controller::ResourcesPathsConcern

      def self.resource_class
        Keepr::CostCenter
      end

      private

      def permitted_params
        params.require(:keepr_cost_center).permit(:number, :name, :note)
      end
    end
  end
end
