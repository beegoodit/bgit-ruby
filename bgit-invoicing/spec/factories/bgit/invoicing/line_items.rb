FactoryBot.define do
  factory :bgit_invoicing_line_item, class: Bgit::Invoicing::LineItem do
    association(:invoice, factory: :bgit_invoicing_invoice)
    association(:subscription, factory: :bgit_invoicing_subscription)
    seconds { 1 }
    price_cents { 1 }
  end
end
