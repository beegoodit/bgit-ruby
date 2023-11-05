FactoryBot.define do
  factory :bgit_invoicing_tier, class: Bgit::Invoicing::Tier do
    association(:product, factory: :bgit_invoicing_product)
    sequence(:identifier) { |i| "tier-#{i}" }
    available_from { Time.zone.now.beginning_of_year }
    available_to { Time.zone.now.end_of_year }
    price_per_month_cents { 1 }
    position { 1 }
  end
end
