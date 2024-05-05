class CreateBgitAccountingContactsRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_contacts_roles do |t|
      t.string :uuid, null: false
      t.references :contact, null: false, foreign_key: {to_table: :bgit_accounting_contacts_contacts}
      t.string :identifier
      t.string :number

      t.timestamps
    end
  end
end
