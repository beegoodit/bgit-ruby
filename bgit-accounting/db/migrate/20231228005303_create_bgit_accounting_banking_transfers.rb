class CreateBgitAccountingBankingTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_banking_transfers do |t|
      t.references :recipient_bank_account, null: false, foreign_key: {to_table: :bgit_accounting_banking_accounts},
        index: {name: "index_bgit_accounting_banking_transfers_on_rec_bank_acc_id"}
      t.references :sender_bank_account, null: false, foreign_key: {to_table: :bgit_accounting_banking_accounts},
        index: {name: "index_bgit_accounting_banking_transfers_on_sen_bank_acc_id"}
      t.timestamp :transaction_at
      t.timestamp :value_at
      t.integer :amount_cents
      t.text :purpose

      t.timestamps
    end
  end
end
