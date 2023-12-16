FactoryBot.define do
  factory :bgit_invoicing_invoice, class: Bgit::Invoicing::Invoice do
    association(:owner, factory: Bgit::Invoicing::Configuration.invoice_owner_factory_name)
    shipping_date { Time.zone.today.beginning_of_month }
    total_net_amount_cents { 100 }
  end
end
