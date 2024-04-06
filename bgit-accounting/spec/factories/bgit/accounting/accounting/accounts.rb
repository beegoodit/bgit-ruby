FactoryBot.define do
  factory :bgit_accounting_accounting_account, class: Bgit::Accounting::Accounting::Account do
    association(:account_category, factory: :bgit_accounting_accounting_account_category)
    association(:accountable, factory: Bgit::Accounting::Configuration.accountable_factory_name)
    account_number { "MyString" }
    label { "MyString" }
    description { "MyText" }
  end
end
