class CreateBgitLexofficeContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_lexoffice_contacts do |t|
      t.references :contactable, polymorphic: true
      t.string :lexoffice_id

      t.timestamps
    end
  end
end
