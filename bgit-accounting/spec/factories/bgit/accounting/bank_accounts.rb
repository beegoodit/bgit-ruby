FactoryBot.define do
  factory :bgit_accounting_bank_account, class: Bgit::Accounting::BankAccount do
    association(:accountable, factory: Bgit::Accounting::Configuration.accountable_factory_name)
    name { "DKB Girokonto" }
    owner { "Jane Doe" }
    # use a sequence to make sure the iban is unique using padding to ensure the length is always the same
    sequence(:iban) { |n| "DE8112030000112345678#{n.to_s.rjust(2, "0")}" }
  end
end
