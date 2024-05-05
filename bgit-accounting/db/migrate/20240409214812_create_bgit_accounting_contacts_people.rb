class CreateBgitAccountingContactsPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_contacts_people do |t|
      t.string :uuid, null: false
      t.references :contact, null: false, foreign_key: {to_table: :bgit_accounting_contacts_contacts}
      t.string :salutation
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
