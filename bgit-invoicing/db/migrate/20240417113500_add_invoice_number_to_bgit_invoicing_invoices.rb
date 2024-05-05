class AddInvoiceNumberToBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :bgit_invoicing_invoices, :invoice_number, :string
  end
end
