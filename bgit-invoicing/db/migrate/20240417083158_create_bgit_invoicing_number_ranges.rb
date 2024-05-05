class CreateBgitInvoicingNumberRanges < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_invoicing_number_ranges do |t|
      t.string :uuid
      t.string :identifier
      t.string :prefix
      t.string :format
      t.integer :next_value
      t.integer :minimum_length

      t.timestamps
    end
  end
end
