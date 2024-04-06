module Bgit::Accounting
  class Vouchers::Unchecked < Vouchers::Voucher
    register_currency :eur
    monetize :amount_cents, with_model_currency: :eur,
      allow_nil: true,
      numericality: {
        greater_than_or_equal_to: 0
      }
  end
end
