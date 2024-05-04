module Bgit
  module Accounting
    module Vouchers
      class CreateService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
        end

        attr_accessor :address_supplement, :customer, :invoice_number, :zip, :city, :country, :street, :customer_number, :invoice_date, :shipping_date,
          :shipping_end_date, :service_date, :voucher_title, :introduction, :payment_terms, :postscript

        private

        def _perform
        end
      end
    end
  end
end
