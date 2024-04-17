class AddInvoiceNumberToBgitInvoicingInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :bgit_invoicing_invoices, :invoice_number, :string
  end
end
