FactoryBot.define do
  factory :bgit_invoicing_invoice, class: Bgit::Invoicing::Invoice do
    association(:owner, factory: Bgit::Invoicing::Configuration.invoice_owner_factory_name)
    year { 1.month.ago.year }
    month { 1.month.ago.month }
    total_price_cents { 1 }
  end
end
