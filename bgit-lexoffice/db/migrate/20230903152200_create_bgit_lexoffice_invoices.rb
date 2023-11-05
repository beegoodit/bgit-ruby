class CreateBgitLexofficeInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_lexoffice_invoices do |t|
      t.references :invoiceable, polymorphic: true
      t.string :lexoffice_id

      t.timestamps
    end
  end
end
