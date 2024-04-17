module Bgit
  module Invoicing
    module NumberRanges
      class SeedService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :number_ranges
        end

        private

        def _perform
          @result.number_ranges = build_number_ranges!
        end

        def build_number_ranges!
          default_number_ranges.collect do |attrs|
            say "Building number range for #{attrs[:identifier]}" do
              Bgit::Invoicing::NumberRange.where(identifier: attrs[:identifier]).first_or_initialize do |nr|
                nr.attributes = attrs
              end
            end
          end
        end

        def default_number_ranges
          [
            {identifier: "invoice_number", prefix: "RE", format: "%Y%m-", next_value: 1, minimum_length: 4},
            {identifier: "quote_number", prefix: "AG", format: "%Y%m-", next_value: 1, minimum_length: 4},
            {identifier: "order_number", prefix: "AB", format: "%Y%m-", next_value: 1, minimum_length: 4},
            {identifier: "delivery_note_number", prefix: "LS", format: "%Y%m-", next_value: 1, minimum_length: 4},
            {identifier: "invoice_correction_number", prefix: "GS", format: "%Y%m-", next_value: 1, minimum_length: 4}
          ]
        end

        def save
          ActiveRecord::Base.transaction do
            @result.number_ranges.map(&:save!)
          end
        end
      end
    end
  end
end
