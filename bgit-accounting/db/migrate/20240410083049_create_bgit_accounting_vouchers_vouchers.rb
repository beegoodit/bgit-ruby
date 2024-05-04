class CreateBgitAccountingVouchersVouchers < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_vouchers_vouchers do |t|
      t.references :contact, null: true, foreign_key: {to_table: :bgit_accounting_contacts_contacts}
      t.references :journal, null: true, foreign_key: {to_table: :keepr_journals}
      t.string :kind
      t.string :number
      t.date :issue_date
      t.date :due_date
      t.string :amount_cents
      t.text :note

      t.timestamps
    end
  end
end
