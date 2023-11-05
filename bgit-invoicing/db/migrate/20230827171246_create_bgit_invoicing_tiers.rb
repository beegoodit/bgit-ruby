class CreateBgitInvoicingTiers < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_tiers do |t|
      t.references :product, null: false, foreign_key: {to_table: :bgit_invoicing_products}
      t.string :uuid
      t.string :identifier
      t.timestamp :available_from
      t.timestamp :available_to
      t.integer :price_per_month_cents
      t.integer :position

      t.timestamps
    end
  end
end
