module Bgit
  module Invoicing
    class LineItemsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::LineItem
      end

      def self.available_rest_actions
        super - %i[new create edit update]
      end
    end
  end
end
