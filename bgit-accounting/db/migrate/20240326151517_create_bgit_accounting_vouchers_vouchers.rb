class CreateBgitAccountingVouchersVouchers < ActiveRecord::Migration[7.0]
  def change
    create_table :bgit_accounting_vouchers_vouchers do |t|
      t.references :accountable, polymorphic: true, null: false
      t.string :type, null: false
      t.string :voucher_number
      t.date :voucher_date
      t.integer :amount_cents
      t.date :due_date
      t.text :description

      t.timestamps
    end
  end
end
