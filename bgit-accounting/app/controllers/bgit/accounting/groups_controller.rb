module Bgit
  module Accounting
    class GroupsController < Cmor::Core::Backend::ResourcesController::Base
      include Bgit::Accounting::Controller::ResourcesPathsConcern

      def self.resource_class
        Keepr::Group
      end

      private

      def permitted_params
        params.require(:keepr_group).permit(
          :is_result,
          :name,
          :number,
          :parent_id,
          :target
        )
      end
    end
  end
end
