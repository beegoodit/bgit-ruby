class AddInvoiceDateToBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :bgit_invoicing_invoices, :invoice_date, :date
  end
end
