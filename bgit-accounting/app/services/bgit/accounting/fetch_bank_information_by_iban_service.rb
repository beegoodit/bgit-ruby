module Bgit
  module Accounting
    class FetchBankInformationByIbanService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :parsed_response

        def iban_valid?
          parsed_response["valid"]
        end

        def bank_code
          @bank_code ||= parsed_response&.dig("bankData", "bankCode")
        end

        def name
          @name ||= parsed_response&.dig("bankData", "name")
        end

        def zip
          @zip ||= parsed_response&.dig("bankData", "zip")
        end

        def city
          @city ||= parsed_response&.dig("bankData", "city")
        end

        def bic
          @bic ||= parsed_response&.dig("bankData", "bic")
        end
      end

      attr_accessor :iban

      validates :iban, presence: true

      private

      def _perform
        @result.parsed_response = fetch_validate!
      end

      def fetch_validate!
        response = HTTParty.get("https://openiban.com/validate/#{iban}?getBIC=true")
        if response.ok?
          response.parsed_response
        else
          add_error_and_say(:base, "Could not fetch bank information for #{iban}. Error(#{response.code}): #{response.body}")
          nil
        end
      end
    end
  end
end
