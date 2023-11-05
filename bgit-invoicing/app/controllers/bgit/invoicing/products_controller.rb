module Bgit
  module Invoicing
    class ProductsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::Product
      end

      private

      def permitted_params
        params.require(:product).permit(:identifier)
      end
    end
  end
end
