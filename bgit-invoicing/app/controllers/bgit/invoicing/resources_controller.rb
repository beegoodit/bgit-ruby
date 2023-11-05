module Bgit
  module Invoicing
    class ResourcesController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::Resource
      end

      private

      def permitted_params
        params.require(:resource).permit(:identifier, :product_id, :owner_id, :owner_type)
      end
    end
  end
end
