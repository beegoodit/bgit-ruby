module Bgit
  module Accounting
    class PostingsController < Cmor::Core::Backend::ResourcesController::Base
      include Bgit::Accounting::Controller::ResourcesPathsConcern

      def self.resource_class
        Keepr::Posting
      end

      def self.available_rest_actions
        super - %i[new create edit update]
      end

      private

      def permitted_params
        params.require(:keepr_posting).permit
      end
    end
  end
end
