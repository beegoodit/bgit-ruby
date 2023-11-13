class AddDescriptionToBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    add_column :bgit_invoicing_line_items, :description, :text
  end
end
