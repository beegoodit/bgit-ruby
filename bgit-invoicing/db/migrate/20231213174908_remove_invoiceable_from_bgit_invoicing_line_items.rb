class RemoveInvoiceableFromBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bgit_invoicing_line_items, :invoiceable, polymorphic: true, null: false
  end
end
