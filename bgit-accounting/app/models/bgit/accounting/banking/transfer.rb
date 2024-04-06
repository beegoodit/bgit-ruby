module Bgit::Accounting
  module Banking
    class Transfer < ApplicationRecord
      belongs_to :recipient_bank_account, class_name: "Bgit::Accounting::Banking::Account", inverse_of: :incoming_transfers
      belongs_to :sender_bank_account, class_name: "Bgit::Accounting::Banking::Account", inverse_of: :outgoing_transfers
      has_many :transfer_vouchers, inverse_of: :transfer
      has_many :vouchers, through: :transfer_vouchers

      validates :value_at, presence: true
      validates :amount_cents, presence: true

      register_currency :eur

      monetize :amount_cents, with_currency: :eur

      def human
        "#{sender_bank_account.human} - #{amount} #{amount.currency} -> #{recipient_bank_account.human}"
      end

      def transfer_vouchers_count
        transfer_vouchers.count
      end

      def vouchers_count
        vouchers.count
      end
    end
  end
end
