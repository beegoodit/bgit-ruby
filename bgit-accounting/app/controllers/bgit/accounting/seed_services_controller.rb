module Bgit
  module Accounting
    class SeedServicesController < Cmor::Core::Backend::ServiceController::Base
      def self.service_class
        Bgit::Accounting::SeedService
      end

      private

      def permitted_params
        params.fetch(:seed_service, {}).permit
      end
    end
  end
end
