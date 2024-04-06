module Bgit
  module Accounting
    module Vouchers
      class UncheckedsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Vouchers::Unchecked
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.require(:vouchers_unchecked).permit(:accountable_type, :accountable_id, :asset)
        end
      end
    end
  end
end
