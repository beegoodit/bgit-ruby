class CreateBgitAccountingVouchersAmounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_vouchers_amounts do |t|
      t.references :voucher, null: false, foreign_key: {to_table: :bgit_accounting_vouchers_vouchers}
      t.references :account, null: false, foreign_key: {to_table: :bgit_accounting_accounting_accounts}
      t.integer :net_amount_cents
      t.integer :tax_amount_cents
      t.integer :tax_rate_percentage

      t.timestamps
    end
  end
end
