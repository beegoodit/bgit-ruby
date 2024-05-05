FactoryBot.define do
  factory :bgit_accounting_accounting_account, class: Bgit::Accounting::Accounting::Account do
    sequence(:number) { |i| i }
    kind { :asset }
    sequence(:name) { |i| "Account ##{i}" }
  end
end
