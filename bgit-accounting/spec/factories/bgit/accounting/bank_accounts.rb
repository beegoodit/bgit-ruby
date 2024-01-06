FactoryBot.define do
  factory :bgit_accounting_bank_account, class: Bgit::Accounting::BankAccount do
    association(:accountable, factory: Bgit::Accounting::Configuration.accountable_factory_name)
    name { "DKB Girokonto" }
    owner { "Jane Doe" }
    iban { "DE81120300001123456789" }
  end
end
