module Bgit
  module Accounting
    class JournalsController < Cmor::Core::Backend::ResourcesController::Base
      include Bgit::Accounting::Controller::ResourcesPathsConcern

      def self.resource_class
        Keepr::Journal
      end

      private

      def permitted_params
        params.require(:keepr_journal).permit(
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
