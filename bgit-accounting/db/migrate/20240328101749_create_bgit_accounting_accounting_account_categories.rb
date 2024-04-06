class CreateBgitAccountingAccountingAccountCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :bgit_accounting_accounting_account_categories do |t|
      t.references :chart, foreign_key: {to_table: :bgit_accounting_accounting_charts}, null: false
      t.string :identifier
      t.string :label
      t.integer :side

      t.timestamps
    end
  end
end
