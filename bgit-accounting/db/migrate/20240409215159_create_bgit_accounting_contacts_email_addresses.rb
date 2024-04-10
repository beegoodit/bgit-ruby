class CreateBgitAccountingContactsEmailAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :bgit_accounting_contacts_email_addresses do |t|
      t.string :uuid, null: false
      t.references :company, null: false, foreign_key: {to_table: :bgit_accounting_contacts_companies}
      t.string :role
      t.string :email

      t.timestamps
    end
  end
end
