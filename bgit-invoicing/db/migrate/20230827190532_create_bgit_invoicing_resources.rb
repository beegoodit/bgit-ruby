class CreateBgitInvoicingResources < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_resources do |t|
      t.references :product, null: false, foreign_key: {to_table: :bgit_invoicing_products}
      t.references :owner, polymorphic: true, null: false
      t.string :uuid
      t.string :identifier

      t.timestamps
    end
  end
end
