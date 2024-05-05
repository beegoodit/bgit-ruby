class CreateBgitAccountingContactsCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_contacts_companies do |t|
      t.string :uuid, null: false
      t.references :contact, null: false, foreign_key: {to_table: :bgit_accounting_contacts_contacts}
      t.string :tax_number
      t.string :vat_identifier

      t.timestamps
    end
  end
end
