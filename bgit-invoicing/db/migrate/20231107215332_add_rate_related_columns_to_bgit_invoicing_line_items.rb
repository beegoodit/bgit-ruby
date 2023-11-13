class AddRateRelatedColumnsToBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    add_column :bgit_invoicing_line_items, :quantity, :decimal
    add_column :bgit_invoicing_line_items, :unit_name, :string
    add_column :bgit_invoicing_line_items, :unit_net_amount_cents, :decimal, precision: 12, scale: 4
    add_column :bgit_invoicing_line_items, :tax_rate_percentage, :integer
  end
end
