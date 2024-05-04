module Bgit
  module Accounting
    module Accounting
      class ChartReportServicesController < Cmor::Core::Backend::ServiceController::Base
        include ActiveStorage::SetCurrent

        def self.service_class
          Bgit::Accounting::Accounting::ChartReportService
        end

        def self.engine_class
          Bgit::Accounting
        end

        private

        def initialize_service
          super
          @service.assign_attributes(permitted_params)
        end

        def permitted_params
          params.fetch(:accounting_chart_report_service, {}).permit(:year)
        end
      end
    end
  end
end
