FactoryBot.define do
  factory :accounting_accountable_chart, class: "Accounting::AccountableChart" do
    accountable { nil }
    chart { nil }
    active_from { "2024-04-05" }
    active_to { "2024-04-05" }
  end
end
