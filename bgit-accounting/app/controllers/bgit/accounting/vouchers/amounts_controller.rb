module Bgit
  module Accounting
    module Vouchers
      class AmountsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Vouchers::Amount
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def load_collection_scope
          super.joins(:account, :voucher)
        end

        def permitted_params
          params.require(:vouchers_amount).permit(
            :voucher_id,
            :amount,
            :tax_amount,
            :tax_rate_percentage
          )
        end
      end
    end
  end
end
