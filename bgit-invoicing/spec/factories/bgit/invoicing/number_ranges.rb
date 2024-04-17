FactoryBot.define do
  factory :bgit_invoicing_number_range, class: "Bgit::Invoicing::NumberRange" do
    sequence(:identifier) { |i| "number_range_#{i}" }
    sequence(:prefix) { |i| (i + 64).chr * 2 }
    format { "%Y%m-" }
    next_value { 1 }
    minimum_length { 4 }
  end
end
