class RenameTotalPriceCentsOnBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    rename_column :bgit_invoicing_invoices, :total_price_cents, :total_net_amount_cents
  end
end
