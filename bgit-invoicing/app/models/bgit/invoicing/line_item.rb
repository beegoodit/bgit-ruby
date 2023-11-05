module Bgit::Invoicing
  class LineItem < ApplicationRecord
    belongs_to :invoice
    belongs_to :subscription

    register_currency Bgit::Invoicing::Configuration.default_currency
    monetize :price_cents

    validates :seconds, presence: true
    validates :subscription, uniqueness: {scope: :invoice_id}

    def owner
      subscription.owner
    end
  end
end
