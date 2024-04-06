FactoryBot.define do
  factory :bgit_accounting_accounting_chart, class: "Bgit::Accounting::Accounting::Chart" do
    sequence(:identifier) { |i| "SKR#{i}" }
    sequence(:label) { |i| "Standard-Konten-Rahmen #{i}" }
  end
end
