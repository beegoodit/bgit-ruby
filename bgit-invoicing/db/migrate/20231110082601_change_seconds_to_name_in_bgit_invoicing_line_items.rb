class ChangeSecondsToNameInBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column :bgit_invoicing_line_items, :seconds, :string
    rename_column :bgit_invoicing_line_items, :seconds, :name
    change_column_null :bgit_invoicing_line_items, :name, false
  end
end
