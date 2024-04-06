module Bgit::Accounting
  class Vouchers::PurchaseInvoice < Vouchers::Voucher
    register_currency :eur
    monetize :amount_cents, with_model_currency: :eur,
      allow_nil: true,
      numericality: {
        greater_than_or_equal_to: 0
      }

    def human
      "#{amount} #{amount&.currency} (#{voucher_date}) - #{voucher_number}"
    end
  end
end
