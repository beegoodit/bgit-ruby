module Bgit::Accounting
  module Banking
    class Transfer < ApplicationRecord
      belongs_to :recipient_bank_account, class_name: "Bgit::Accounting::Banking::Account", inverse_of: :incoming_transfers
      belongs_to :sender_bank_account, class_name: "Bgit::Accounting::Banking::Account", inverse_of: :outgoing_transfers
      belongs_to :journal, class_name: "Keepr::Journal", optional: true
      has_many :postings, class_name: "Keepr::Posting", through: :journal, source: :keepr_postings

      validates :value_at, presence: true
      validates :amount_cents, presence: true

      register_currency :eur

      monetize :amount_cents, with_currency: :eur

      scope :unchecked, -> { joins(postings: :keepr_account).where(keepr_accounts: {id: Keepr::Account.where(number: [133710, 133720]).pluck(:id)}).distinct }

      def human
        "#{sender_bank_account.human} -> #{recipient_bank_account.human} (#{amount})"
      end

      def self.human_scope_name(scope)
        I18n.t(scope, scope: "activerecord.scopes.#{model_name.i18n_key}")
      end

      module DigestConcern
        extend ActiveSupport::Concern

        included do
          before_validation :set_digest
          validates :digest, presence: true, uniqueness: true
        end

        def digest
          return if sender_bank_account.nil? || recipient_bank_account.nil?
          Digest::SHA1.hexdigest("#{sender_bank_account.iban}#{recipient_bank_account.iban}#{amount_cents}#{value_at}#{purpose}")
        end

        private

        def set_digest
          self.digest = digest
        end
      end

      include DigestConcern
    end
  end
end
