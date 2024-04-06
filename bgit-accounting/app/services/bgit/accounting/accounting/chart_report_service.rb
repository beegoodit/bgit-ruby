module Bgit
  module Accounting
    module Accounting
      class ChartReportService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :accounts, :chart, :year
        end

        attr_accessor :accountable_type, :accountable_id, :year

        def accountable
          @accountable ||= accountable_type&.constantize&.find(accountable_id)
        end

        def chart
          @chart ||= Bgit::Accounting::Accounting::AccountableChart.active_now.find_by(accountable: accountable)&.chart
        end

        private

        def _perform
          @result.accounts = Bgit::Accounting::Accounting::Account.where(accountable: accountable).all
          @result.chart = chart
          @result.year = year
        end
      end
    end
  end
end
