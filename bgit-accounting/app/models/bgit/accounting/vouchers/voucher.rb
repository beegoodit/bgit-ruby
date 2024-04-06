module Bgit::Accounting
  class Vouchers::Voucher < ApplicationRecord
    VOUCHER_TYPES = %w[
      Bgit::Accounting::Vouchers::PurchaseInvoice
      Bgit::Accounting::Vouchers::SalesInvoice
      Bgit::Accounting::Vouchers::Unchecked
    ]

    ASSIGNABLE_VOUCHER_TYPES = %w[
      Bgit::Accounting::Vouchers::PurchaseInvoice
      Bgit::Accounting::Vouchers::SalesInvoice
    ]

    belongs_to :accountable, polymorphic: true
    has_many :amounts, foreign_key: "voucher_id", class_name: "Bgit::Accounting::Vouchers::Amount", dependent: :destroy, inverse_of: :voucher
    has_many :transfer_vouchers, class_name: "Bgit::Accounting::Banking::TransferVoucher", inverse_of: :voucher
    has_many :transfers, class_name: "Bgit::Accounting::Banking::Transfer", through: :transfer_vouchers, source: :transfer

    has_one_attached :asset do |attachable|
      attachable.variant :thumb, resize_to_limit: [99, 140]
    end

    register_currency :eur
    monetize :amount_cents, with_model_currency: :eur,
      allow_nil: true,
      numericality: {
        greater_than_or_equal_to: 0
      }

    validates :asset,
      attached: true,
      content_type: %w[application/pdf]

    def human
      to_s
    end
  end
end
