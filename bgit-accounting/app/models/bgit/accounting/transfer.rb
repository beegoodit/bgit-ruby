module Bgit::Accounting
  class Transfer < ApplicationRecord
    belongs_to :recipient_bank_account, class_name: "Bgit::Accounting::BankAccount", inverse_of: :incoming_transfers
    belongs_to :sender_bank_account, class_name: "Bgit::Accounting::BankAccount", inverse_of: :outgoing_transfers

    validates :value_at, presence: true
    validates :amount_cents, presence: true

    monetize :amount_cents, currency: :eur
  end
end
