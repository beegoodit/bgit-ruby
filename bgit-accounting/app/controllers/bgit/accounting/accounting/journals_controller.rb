module Bgit
  module Accounting
    module Accounting
      class JournalsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Accounting::Journal
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:accounting_journal).permit(
            :accountable,
            :number,
            :date,
            :subject,
            :note,
            :permanent,
            keepr_postings_attributes: [:id, :keepr_account_id, :amount, :side, :_destroy]
          )
        end
      end
    end
  end
end
