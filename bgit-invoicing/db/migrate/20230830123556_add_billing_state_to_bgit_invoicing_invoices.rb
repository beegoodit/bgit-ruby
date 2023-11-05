class AddBillingStateToBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :bgit_invoicing_invoices, :billing_state, :string
  end
end
