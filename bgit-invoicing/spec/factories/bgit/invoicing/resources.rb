FactoryBot.define do
  factory :bgit_invoicing_resource, class: Bgit::Invoicing::Resource do
    association(:product, factory: :bgit_invoicing_product)
    association(:owner, factory: Bgit::Invoicing::Configuration.resource_owner_factory_name)
    sequence(:identifier) { |i| "resource-#{i}" }
  end
end
