class CreateBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_line_items do |t|
      t.references :invoice, null: false, foreign_key: {to_table: :bgit_invoicing_invoices}
      t.references :subscription, null: false, foreign_key: {to_table: :bgit_invoicing_subscriptions}
      t.string :uuid
      t.integer :seconds
      t.integer :price_cents

      t.timestamps
    end
  end
end
