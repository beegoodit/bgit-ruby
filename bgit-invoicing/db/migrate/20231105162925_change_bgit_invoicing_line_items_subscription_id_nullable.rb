class ChangeBgitInvoicingLineItemsSubscriptionIdNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bgit_invoicing_line_items, :subscription_id, true
  end
end
