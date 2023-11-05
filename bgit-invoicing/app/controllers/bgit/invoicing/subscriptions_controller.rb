module Bgit
  module Invoicing
    class SubscriptionsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::Subscription
      end

      private

      def load_resource
        super
      rescue => e
        raise e # binding.pry
      end

      def permitted_params
        params.require(:subscription).permit(:tier_id, :resource_id, :active_from, :active_to)
      end
    end
  end
end
