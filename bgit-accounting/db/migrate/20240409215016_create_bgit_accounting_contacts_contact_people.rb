class CreateBgitAccountingContactsContactPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_contacts_contact_people do |t|
      t.string :uuid, null: false
      t.references :company, null: false, foreign_key: {to_table: :bgit_accounting_contacts_companies}
      t.string :salutation
      t.string :firstname
      t.string :lastname
      t.boolean :primary
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
