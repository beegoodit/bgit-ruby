class AddShippingDatesToBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :bgit_invoicing_invoices, :shipping_date, :date
    add_column :bgit_invoicing_invoices, :shipping_end_date, :date
  end
end
