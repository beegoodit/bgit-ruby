module Bgit::Invoicing
  class LineItem < ApplicationRecord
    belongs_to :invoice
    belongs_to :invoiceable, polymorphic: true
    if Object.const_defined?("Bgit::Pricing")
      # TODO: Change this to a polymorphic association named billable.
      belongs_to :subscription, class_name: "Bgit::Pricing::Subscription"
      validates :subscription, uniqueness: {scope: :invoice_id}
    end

    register_currency Bgit::Invoicing::Configuration.default_currency
    monetize :unit_net_amount_cents
    monetize :net_amount_cents
    monetize :tax_amount_cents
    monetize :gross_amount_cents

    validates :quantity, presence: true, numericality: {greater_than: 0}
    validates :unit_name, presence: true
    validates :unit_net_amount_cents, presence: true, numericality: {greater_than: 0}
    validates :tax_rate_percentage, presence: true, numericality: {greater_or_equal_than: 0, less_than_or_equal_to: 100}

    validates :name, presence: true

    def owner
      subscription.owner
    end

    def net_amount_cents
      return 0.0 if [unit_net_amount_cents, quantity].any?(&:nil?)
      unit_net_amount_cents * quantity
    end

    def tax_amount_cents
      return 0.0 if [net_amount_cents, tax_rate_percentage].any?(&:nil?)
      net_amount_cents * tax_rate_percentage / 100
    end

    def gross_amount_cents
      net_amount_cents + tax_amount_cents
    end
  end
end
