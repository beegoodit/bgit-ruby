class CreateBgitAccountingContactsAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :bgit_accounting_contacts_addresses do |t|
      t.string :uuid, null: false
      t.references :company, null: false, foreign_key: {to_table: :bgit_accounting_contacts_companies}
      t.string :role
      t.string :supplement
      t.string :street
      t.string :zip_code
      t.string :city
      t.string :country_code

      t.timestamps
    end
  end
end
