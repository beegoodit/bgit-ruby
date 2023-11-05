module Bgit
  module Invoicing
    class TiersController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::Tier
      end

      private

      def permitted_params
        params.require(:tier).permit(:identifier, :product_id, :price_per_month, :available_from, :available_to)
      end
    end
  end
end
