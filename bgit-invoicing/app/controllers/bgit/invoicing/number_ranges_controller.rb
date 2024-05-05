module Bgit
  module Invoicing
    class NumberRangesController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::NumberRange
      end

      private

      def permitted_params
        params.require(:number_range).permit(
          :format,
          :identifier,
          :minimum_length,
          :next_value,
          :prefix
        )
      end
    end
  end
end
