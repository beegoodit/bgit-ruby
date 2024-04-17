module Bgit
  module Invoicing
    class NextNumberService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :value, :number_range
      end

      attr_accessor :identifier

      validates :identifier, presence: true
      validates :number_range, presence: true

      def number_range
        @number_range ||= Bgit::Invoicing::NumberRange.where(identifier: identifier).first
      end

      private

      def _perform
        @result.value = fetch_next_value!
      end

      def fetch_next_value!
        say "Fetching next value for number range #{number_range.identifier}" do
          @number_range.with_lock do
            @number_range.next_formatted_value.tap do |nfv|
              say "Incrementing next value for number range #{number_range.identifier} to #{number_range.next_value + 1}" do
                @number_range.increment!(:next_value)
              end
              say "Value is #{nfv}"
            end
          end
        end
      end
    end
  end
end
