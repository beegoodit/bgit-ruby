FactoryBot.define do
  factory :bgit_accounting_vouchers_amount, class: Bgit::Accounting::Vouchers::Amount do
    association(:voucher, factory: :bgit_accounting_vouchers_purchase_invoice)
    association(:account, factory: :bgit_accounting_accounting_account)
    net_amount { 100.00 }
    tax_amount { 19.00 }
    tax_rate_percentage { 19.00 }
  end
end
