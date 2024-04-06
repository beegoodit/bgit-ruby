FactoryBot.define do
  factory :bgit_accounting_banking_transfer_voucher, class: "Bgit::Accounting::Banking::TransferVoucher" do
    association(:transfer, factory: :bgit_accounting_banking_transfer)
    association(:voucher, factory: :bgit_accounting_vouchers_purchase_invoice)
  end
end
