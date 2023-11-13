class RemovePriceCentsFromBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :bgit_invoicing_line_items, :price_cents, :integer
  end
end
