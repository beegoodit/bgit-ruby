FactoryBot.define do
  factory :bgit_accounting_accounting_account_category, class: "Bgit::Accounting::Accounting::AccountCategory" do
    association(:chart, factory: :bgit_accounting_accounting_chart)
    sequence(:identifier) { |i| "account_category_#{i}" }
    sequence(:label) { |i| "Account Category ##{i}" }
    side { "income" }
  end
end
