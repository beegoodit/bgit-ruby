class RemoveSubscriptionFromBgitInvoicingLineItems < ActiveRecord::Migration[7.0]
  def change
    remove_reference :bgit_invoicing_line_items, :subscription, null: false, foreign_key: {to_table: :bgit_invoicing_subscriptions}
  end
end
