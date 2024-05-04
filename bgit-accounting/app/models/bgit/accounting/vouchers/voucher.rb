module Bgit::Accounting
  class Vouchers::Voucher < ApplicationRecord
    include Bgit::Accounting::Model::HumanValueNameConcern

    belongs_to :contact, class_name: "Bgit::Accounting::Contacts::Contact", optional: true
    belongs_to :journal, class_name: "Keepr::Journal", optional: true
    has_many :postings, class_name: "Keepr::Posting", through: :journal, source: :keepr_postings

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

    module KindConcern
      extend ActiveSupport::Concern

      included do
        KINDS = %w[unchecked purchase_invoice sales_invoice]

        validates :kind, presence: true
        validates :kind, inclusion: {in: KINDS}

        after_initialize :set_kind_defaults, if: :new_record?
      end

      private

      def set_kind_defaults
        self.kind ||= "unchecked"
      end
    end

    include KindConcern
  end
end
