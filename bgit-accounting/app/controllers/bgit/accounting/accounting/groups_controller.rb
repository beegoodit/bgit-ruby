module Bgit
  module Accounting
    module Accounting
      class GroupsController < Cmor::Core::Backend::ResourcesController::Base
        # include Bgit::Accounting::Controller::ResourcesPathsConcern

        def self.resource_class
          Bgit::Accounting::Accounting::Group
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:accounting_group).permit(
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
end
