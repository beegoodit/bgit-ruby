module Bgit
  module Accounting
    module Accounting
      class ChartReportService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :groups, :year
        end

        attr_accessor :year

        private

        def _perform
          @result.groups = Bgit::Accounting::Accounting::Group.roots.all
          @result.year = year
        end
      end
    end
  end
end
