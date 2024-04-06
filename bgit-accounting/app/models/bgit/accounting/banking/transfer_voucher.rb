module Bgit::Accounting
  class Banking::TransferVoucher < ApplicationRecord
    belongs_to :transfer, inverse_of: :transfer_vouchers
    belongs_to :voucher, class_name: "Bgit::Accounting::Vouchers::Voucher", inverse_of: :transfer_vouchers
    has_one :recipient_bank_account, through: :transfer
    has_one :sender_bank_account, through: :transfer

    delegate :asset, to: :voucher, allow_nil: true, prefix: true

    def human
      "#{sender_bank_account.human} - #{transfer.amount} #{transfer.amount.currency} -> #{recipient_bank_account.human}"
    end
  end
end
