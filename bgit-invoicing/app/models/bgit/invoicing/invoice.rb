module Bgit::Invoicing
  # This class represents an invoice. It is used to bill things to an owner
  # for a specific month.
  class Invoice < ApplicationRecord
    include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern

    # autocomplete scope: ->(matcher) { where("lower(bgit_invoicing_invoices.name) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

    belongs_to :owner, polymorphic: true
    has_many :line_items, inverse_of: :invoice, dependent: :destroy

    if Object.const_defined?("Bgit::Lexoffice")
      has_one :lexoffice_invoice, as: :invoiceable, class_name: "Bgit::Lexoffice::Invoice", dependent: :restrict_with_error

      delegate :lexoffice_document, to: :lexoffice_invoice, allow_nil: true
    end

    register_currency Bgit::Invoicing::Configuration.default_currency
    monetize :total_net_amount_cents

    validates :shipping_date, presence: true
    validates :total_net_amount_cents, presence: true
    # validate shipping date to be at the beginning of the month
    validates :shipping_date_day, inclusion: {in: [1]}, if: -> { Cmor::Core::Settings.get(:bgit_invoicing, :enforce_unique_invoices_per_owner_and_month) }
    # validate shipping date to be unique for the owner
    validates :shipping_date, uniqueness: {scope: [:owner_id, :owner_type]}, if: -> { Cmor::Core::Settings.get(:bgit_invoicing, :enforce_unique_invoices_per_owner_and_month) }

    scope :owned_by_any, ->(*owners) { where(owner: owners.flatten) }

    def owned_by_any(*owners)
      owners.flatten.include?(owner)
    end

    def line_items_count
      line_items.count
    end

    def human
      "#{owner.human} - #{I18n.l(shipping_date)}"
    end

    def shipping_date_day
      shipping_date&.day
    end

    include AASM

    aasm :billing, column: :billing_state do
      state :draft, initial: true
      state :at_accounting
      state :open
      state :overdue
      state :paid
      state :canceled

      event :invoice_sent_to_customer do
        transitions from: :at_accounting, to: :open
      end

      event :send_to_accounting do
        transitions from: :draft, to: :at_accounting, after: :send_invoice_to_accounting!
      end

      event :pay do
        transitions from: [:open, :overdue], to: :paid
      end

      event :cancel do
        transitions from: [:draft, :open, :overdue, :at_accounting], to: :canceled
      end

      event :reset do
        transitions from: [:canceled, :paid], to: :draft
      end

      event :mark_as_overdue do
        transitions from: :open, to: :overdue
      end
    end

    def send_invoice_to_accounting!
      service_class = Bgit::Invoicing::Configuration.accounting_services_classes.dig(:invoices, :create).constantize
      result = service_class.call!(invoice: self)

      if result.failed?
        errors.add(:send_to_accounting, result.errors.full_messages.to_sentence)
        raise ActiveRecord::RecordInvalid.new(self)
      end

      true
    end

    module LineItemCalculationsConcern
      extend ActiveSupport::Concern

      included do
        before_validation :set_total_net_amount
      end

      private

      def set_total_net_amount
        self.total_net_amount_cents = line_items.sum(&:net_amount_cents)
      end
    end

    include LineItemCalculationsConcern
  end
end
