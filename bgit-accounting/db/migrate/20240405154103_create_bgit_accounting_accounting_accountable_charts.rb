class CreateBgitAccountingAccountingAccountableCharts < ActiveRecord::Migration[7.1]
  def change
    create_table :bgit_accounting_accounting_accountable_charts do |t|
      t.references :accountable, polymorphic: true, null: false,
        index: {name: "index_bgit_accounting_accounting_accountable_charts_on_acc"}
      t.references :chart, null: false, foreign_key: {to_table: :bgit_accounting_accounting_charts}
      t.date :active_from
      t.date :active_to

      t.timestamps
    end
  end
end
