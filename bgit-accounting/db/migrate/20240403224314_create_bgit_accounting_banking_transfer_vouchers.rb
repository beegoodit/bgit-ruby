class CreateBgitAccountingBankingTransferVouchers < ActiveRecord::Migration[7.1]
  def change
    create_table :bgit_accounting_banking_transfer_vouchers do |t|
      t.references :transfer, null: false, foreign_key: {to_table: :bgit_accounting_banking_transfers}
      t.references :voucher, null: false, foreign_key: {to_table: :bgit_accounting_vouchers_vouchers}
      t.text :note

      t.timestamps
    end
  end
end
