FactoryBot.define do
  factory :bgit_accounting_transfer, class: Bgit::Accounting::Transfer do
    association(:recipient_bank_account, factory: :bgit_accounting_bank_account)
    association(:sender_bank_account, factory: :bgit_accounting_bank_account)
    transaction_at { 2.days.ago }
    value_at { 1.day.ago }
    amount_cents { 42_00 }
  end
end
