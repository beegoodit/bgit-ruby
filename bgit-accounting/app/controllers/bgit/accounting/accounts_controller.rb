module Bgit
  module Accounting
    class AccountsController < Cmor::Core::Backend::ResourcesController::Base
      include Bgit::Accounting::Controller::ResourcesPathsConcern

      def self.resource_class
        Keepr::Account
      end

      private

      def permitted_params
        params.require(:keepr_account).permit(
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
