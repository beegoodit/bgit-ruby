class CreateBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_invoices do |t|
      t.references :owner, polymorphic: true, null: false
      t.string :uuid
      t.string :year
      t.string :month
      t.integer :total_price_cents

      t.timestamps
    end
  end
end
