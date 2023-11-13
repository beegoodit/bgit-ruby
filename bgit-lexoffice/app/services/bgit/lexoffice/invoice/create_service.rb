module Bgit
  module Lexoffice
    class Invoice::CreateService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :lexoffice_invoice
      end

      attr_accessor :invoice

      validates :invoice, presence: true
      validates :contact_lexoffice_id, presence: true

      private

      def _perform
        # send invoice to lexoffice
        @create_invoice_at_lexoffice_result = create_invoice_at_lexoffice!
        return if @errors.any?

        # create Bgit::Lexoffice::Invoice
        @result.lexoffice_invoice = create_lexoffice_invoice
      end

      def contact_lexoffice_id
        @contact_lexoffice_id ||= invoice.owner.lexoffice_contact&.lexoffice_id
      end

      def create_invoice_at_lexoffice!
        result = LexofficeClient::Invoice::CreateService.call(invoice: invoice_as_lexoffice_invoice)

        if result.failed?
          add_error_and_say(:create_invoice_at_lexoffice, result.errors.full_messages.to_sentence)
        end
        result
      end

      def create_lexoffice_invoice
        Bgit::Lexoffice::Invoice.create!(
          invoiceable: invoice,
          lexoffice_id: @create_invoice_at_lexoffice_result.invoice_meta["id"]
        )
      end

      # Explanation about why we need to use Time.use_zone("Europe/Berlin") here:
      #
      # Services are shipped from Germany. For the invoice to show the correct
      # shipping begin and end date, we need to use the correct timezone.
      def shipping_base_date
        Time.use_zone("Europe/Berlin") do
          @shipping_base_date ||= Time.zone.parse("#{invoice.year}-#{invoice.month}-01")
        end
      end

      def shipping_date
        @shipping_date ||= shipping_base_date.beginning_of_month
      end

      def shipping_end_date
        @shipping_end_date ||= shipping_base_date.end_of_month
      end

      def voucher_date
        @voucher_date ||= Time.zone.now
      end

      def invoice_as_lexoffice_invoice
        LexofficeClient::Invoice.new(
          address: LexofficeClient::Address.new(
            contact_id: contact_lexoffice_id
            # name: "Art der Gestaltung GbR",
            # supplement: "c/o Christoph Bönning",
            # street: "Parkstraße 17",
            # city: "Bad Vilbel",
            # zip: "61118",
            # country_code: "DE"
          ),
          voucher_date: voucher_date.utc,
          line_items: invoice.line_items.collect { |line_item| line_item_as_lexoffice_line_item(line_item) },
          tax_conditions: LexofficeClient::TaxConditions.new(tax_type: "net"),
          shipping_conditions: LexofficeClient::ShippingConditions.new(
            shipping_date: shipping_date.utc,
            shipping_end_date: shipping_end_date.utc,
            shipping_type: "serviceperiod"
          ),
          total_price: LexofficeClient::TotalPrice.new(currency: "EUR")
          # contact: owner.to_lexoffice_contact,
          # invoice_date: Date.new(year, month, 1),
          # due_date: Date.new(year, month, 1) + 14.days,
          # invoice_number: invoice_number,
          # currency: Bgit::Invoicing::Configuration.default_currency,
          # line_items: line_items.collect(&:to_lexoffice_line_item)
        )
      end

      def line_item_as_lexoffice_line_item(line_item)
        LexofficeClient::LineItem.new(
          type: "custom",
          # name: "#{line_item.subscription.tier.product.identifier} - #{line_item.subscription.tier.identifier}",
          name: line_item.name,
          # description: line_item.subscription.resource.identifier,
          description: line_item.description,
          # quantity: 1,
          quantity: line_item.quantity,
          # unit_name: "Stück",
          unit_name: line_item.unit_name,
          unit_price: LexofficeClient::UnitPrice.new(
            currency: line_item.net_amount.currency.to_s,
            net_amount: line_item.unit_net_amount.to_f,
            # gross_amount: line_item.unit_gross_amount.to_f,
            tax_rate_percentage: line_item.tax_rate_percentage
          ),
          # unit_price: LexofficeClient::UnitPrice.new(
          #   currency: "EUR",
          #   net_amount: line_item.price.to_f,
          #   gross_amount: (line_item.price.to_f * 1.19).round(2),
          #   tax_rate_percentage: 19
          # ),
          discount_percentage: 0,
          # line_item_amount: 100.0
        )
      end
    end
  end
end
