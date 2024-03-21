class CreateBgitAccountingTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_transfers do |t|
      t.references :recipient_bank_account, null: false, foreign_key: {to_table: :bgit_accounting_bank_accounts}
      t.references :sender_bank_account, null: false, foreign_key: {to_table: :bgit_accounting_bank_accounts}
      t.timestamp :transaction_at
      t.timestamp :value_at
      t.integer :amount_cents
      t.text :purpose

      t.timestamps
    end
  end
end
