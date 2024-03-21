module Bgit::Accounting
  class BankAccount < ApplicationRecord
    include Bgit::Accounting::Model::ActiveConcern

    belongs_to :accountable, polymorphic: true, optional: true
    has_many :incoming_transfers, class_name: "Bgit::Accounting::Transfer", foreign_key: "recipient_bank_account_id", inverse_of: :recipient_bank_account
    has_many :outgoing_transfers, class_name: "Bgit::Accounting::Transfer", foreign_key: "sender_bank_account_id", inverse_of: :sender_bank_account

    validates :name, presence: true
    validates :iban, presence: true, uniqueness: true
    validates :active_from, presence: true
    validates :active_to, presence: true

    def human
      "#{name} (#{iban})"
    end

    def iban=(value)
      # remove spaces and underscores
      super(value&.gsub(/[\s_]/, ""))
    end

    def transfers
      Bgit::Accounting::Transfer.where("recipient_bank_account_id = :id OR sender_bank_account_id = :id", id: id)
    end
  end
end
