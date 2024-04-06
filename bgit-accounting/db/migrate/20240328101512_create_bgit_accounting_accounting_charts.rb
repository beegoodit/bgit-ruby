class CreateBgitAccountingAccountingCharts < ActiveRecord::Migration[7.1]
  def change
    create_table :bgit_accounting_accounting_charts do |t|
      t.string :identifier
      t.string :label

      t.timestamps
    end
  end
end
