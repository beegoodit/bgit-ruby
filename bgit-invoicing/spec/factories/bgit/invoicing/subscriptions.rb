FactoryBot.define do
  factory :bgit_invoicing_subscription, class: Bgit::Invoicing::Subscription do
    association(:tier, factory: :bgit_invoicing_tier)
    association(:resource, factory: :bgit_invoicing_resource)
    active_from { Time.zone.now.beginning_of_month }
    active_to { Time.zone.now.end_of_month }
  end
end
