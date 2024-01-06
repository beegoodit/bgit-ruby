module Bgit
  module Accounting
    class TransfersController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Accounting::Transfer
      end

      private

      def permitted_params
        params.require(:transfer).permit
      end
    end
  end
end
