module Bgit::Accounting
  module Accounting
    class Account < ApplicationRecord
      include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern

      belongs_to :account_category
      belongs_to :accountable, polymorphic: true
      has_many :amounts, class_name: "Bgit::Accounting::Vouchers::Amount", foreign_key: "account_id", inverse_of: :account
      has_many :vouchers, class_name: "Bgit::Accounting::Vouchers::Voucher", through: :amounts
      has_many :transfers, class_name: "Bgit::Accounting::Banking::Transfer", through: :vouchers

      validates :account_number, presence: true
      validates :label, presence: true

      autocomplete scope: ->(matcher) { where("account_number LIKE :term OR lower(label) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

      def human
        [account_number, label].join(" - ")
      end

      def amounts_count
        amounts.count
      end

      def vouchers_count
        vouchers.count
      end
    end
  end
end
