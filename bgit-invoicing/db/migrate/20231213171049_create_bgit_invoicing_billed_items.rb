class CreateBgitInvoicingBilledItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_billed_items do |t|
      t.references :line_item, null: false, foreign_key: {to_table: :bgit_invoicing_line_items}
      t.references :billable, polymorphic: true, null: false
      t.string :uuid

      t.timestamps
    end
  end
end
