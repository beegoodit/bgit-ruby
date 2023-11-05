class CreateBgitInvoicingSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_subscriptions do |t|
      t.references :tier, null: false, foreign_key: {to_table: :bgit_invoicing_tiers}
      t.references :resource, null: false, foreign_key: {to_table: :bgit_invoicing_resources}
      t.string :uuid
      t.timestamp :active_from
      t.timestamp :active_to

      t.timestamps
    end
  end
end
