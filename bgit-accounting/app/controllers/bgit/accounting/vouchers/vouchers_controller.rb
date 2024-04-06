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

        def after_create_location
          url_for([@resource.becomes(Bgit::Accounting::Vouchers::Voucher)])
        end

        def after_destroy_location
          url_for([Bgit::Accounting::Vouchers::Voucher])
        end

        def permitted_params
          params.require(:vouchers_voucher).permit(:accountable_type, :accountable_id, :asset, :type)
        end
      end
    end
  end
end
