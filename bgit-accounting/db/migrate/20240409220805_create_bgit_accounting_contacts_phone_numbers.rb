class CreateBgitAccountingContactsPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_contacts_phone_numbers do |t|
      t.string :uuid, null: false
      t.references :company, null: false, foreign_key: {to_table: :bgit_accounting_contacts_companies}
      t.string :role
      t.string :number

      t.timestamps
    end
  end
end
