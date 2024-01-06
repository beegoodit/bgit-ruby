class CreateBgitAccountingBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_bank_accounts do |t|
      t.references :accountable, polymorphic: true
      t.string :name
      t.string :owner
      t.string :iban
      t.timestamp :active_from
      t.timestamp :active_to

      t.timestamps
    end
  end
end
