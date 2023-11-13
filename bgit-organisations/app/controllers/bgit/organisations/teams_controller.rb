module Bgit
  module Organisations
    class TeamsController < Cmor::Core::Backend::ResourcesController::Base
      include SimpleFormPolymorphicAssociations::Controller::AutocompleteConcern
      
      def self.resource_class
        Bgit::Organisations::Team
      end

      private

      def permitted_params
        params.require(:team).permit(:name)
      end
    end
  end
end
