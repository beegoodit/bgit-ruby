module Bgit
  module Organisations
    class TeamMembershipsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Organisations::TeamMembership
      end

      private

      def permitted_params
        params.require(:team_membership).permit(:member_id, :team_id)
      end

      def default_query_params_exceptions
        super << "populate"
      end
    end
  end
end
