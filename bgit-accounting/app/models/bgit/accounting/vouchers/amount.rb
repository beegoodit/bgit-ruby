module Bgit::Accounting
  class Vouchers::Amount < ApplicationRecord
    belongs_to :voucher, foreign_key: "voucher_id", inverse_of: :amounts
    belongs_to :account, class_name: "Bgit::Accounting::Accounting::Account"
    has_one :transfer, class_name: "Bgit::Accounting::Banking::Transfer", through: :voucher

    register_currency :eur
    monetize :net_amount_cents, with_model_currency: :eur
    monetize :tax_amount_cents, with_model_currency: :eur

    validates :net_amount_cents, presence: true
    validates :tax_amount_cents, presence: true
    validates :tax_rate_percentage, presence: true

    scope :transferred_in_year, ->(year) { joins(:transfer).where("bgit_accounting_banking_transfers.value_at >= ? AND bgit_accounting_banking_transfers.value_at <= ?", Date.new(year.to_i, 1, 1), Date.new(year.to_i, 12, 31)) }

    def gross_amount
      (net_amount || 0) + (tax_amount || 0)
    end

    def human
      "#{account.accountable.human} #{account.account_number} #{gross_amount}: #{gross_amount.currency}"
    end

    private

    module I18nDecimalHandlingConcern
      extend ActiveSupport::Concern

      def net_amount=(value)
        case value
        when String
          # get decimal separator from I18n
          separator = I18n.t("number.format.separator")
          method(:net_amount).super_method.call(value.gsub(separator, "."))
        else
          method(:net_amount).super_method.call(value)
        end
      end

      def tax_amount=(value)
        case value
        when String
          # get decimal separator from I18n
          separator = I18n.t("number.format.separator")
          method(:tax_amount).super_method.call(value.gsub(separator, "."))
        else
          method(:tax_amount).super_method.call(value)
        end
      end
    end

    # prepend I18nDecimalHandlingConcern
  end
end
