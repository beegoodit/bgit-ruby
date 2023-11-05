FactoryBot.define do
  factory :bgit_invoicing_product, class: "Bgit::Invoicing::Product" do
    sequence(:identifier) { |i| "product-#{i}" }
  end
end
