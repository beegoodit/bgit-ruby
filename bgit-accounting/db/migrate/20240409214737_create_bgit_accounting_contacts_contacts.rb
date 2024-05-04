class CreateBgitAccountingContactsContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_contacts_contacts do |t|
      t.string :uuid, null: false
      t.string :name
      t.text :note

      t.timestamps
    end
  end
end
