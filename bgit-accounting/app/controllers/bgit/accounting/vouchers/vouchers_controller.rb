module Bgit
  module Accounting
    module Vouchers
      class VouchersController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Vouchers::Voucher
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def permitted_params
          params.fetch(:vouchers_voucher, {}).permit(:asset, :journal_id)
        end
      end
    end
  end
end
