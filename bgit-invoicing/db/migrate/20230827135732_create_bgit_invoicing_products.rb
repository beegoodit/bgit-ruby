class CreateBgitInvoicingProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_products do |t|
      t.string :uuid
      t.string :identifier

      t.timestamps
    end
  end
end
