FactoryBot.define do
  factory :bgit_invoicing_billed_item, class: Bgit::Invoicing::BilledItem do
    association(:line_item, factory: :bgit_invoicing_line_item)
    association(:billable, factory: Bgit::Invoicing::Configuration.billed_item_billable_factory_name)
  end
end
