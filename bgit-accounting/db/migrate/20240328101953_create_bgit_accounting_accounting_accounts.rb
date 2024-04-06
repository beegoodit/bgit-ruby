class CreateBgitAccountingAccountingAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_accounting_accounts do |t|
      t.references :account_category, foreign_key: {to_table: :bgit_accounting_accounting_account_categories}, null: false
      t.references :accountable, polymorphic: true, null: false
      t.string :account_number
      t.string :label
      t.text :description

      t.timestamps
    end
  end
end
