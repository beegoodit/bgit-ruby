module Bgit
  module Accounting
    module Accounting
      class PostingsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::Posting
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def after_update_location
          last_location
        end

        def load_collection_scope
          super.includes(:keepr_account, :keepr_journal)
        end

        def permitted_params
          params.require(:accounting_posting).permit(
            :keepr_account_id,
            :keepr_journal_id,
            :amount,
            :keepr_cost_center_id,
            :accountable_id,
            :accountable_type
          )
        end
      end
    end
  end
end
