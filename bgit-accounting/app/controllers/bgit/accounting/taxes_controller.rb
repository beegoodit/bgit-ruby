module Bgit
  module Accounting
    class TaxesController < Cmor::Core::Backend::ResourcesController::Base
      include Bgit::Accounting::Controller::ResourcesPathsConcern

      def self.resource_class
        Keepr::Tax
      end

      private

      def permitted_params
        params.require(:keepr_tax).permit(:name, :value, :keepr_account_id)
      end
    end
  end
end
