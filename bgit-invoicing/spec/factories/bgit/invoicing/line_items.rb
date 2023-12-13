FactoryBot.define do
  factory :bgit_invoicing_line_item, class: Bgit::Invoicing::LineItem do
    association(:invoice, factory: :bgit_invoicing_invoice)
    name { "Service usage" }
    # This line item represents 1 minunte of usage billed at 0.1 cents per second.
    quantity { 60 }
    unit_name { "Sekunden" }
    unit_net_amount_cents { 0.1 }
    tax_rate_percentage { 19 }
  end
end
