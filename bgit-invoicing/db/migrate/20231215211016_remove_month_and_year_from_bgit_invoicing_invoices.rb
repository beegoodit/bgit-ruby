class RemoveMonthAndYearFromBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    # raise if there are any invoices without a shipping_date or shipping_end_date
    if Bgit::Invoicing::Invoice.where(shipping_date: nil).or(Bgit::Invoicing::Invoice.where(shipping_end_date: nil)).any?
      raise "There are invoices without a shipping_date or shipping_end_date"
    end
    remove_column :bgit_invoicing_invoices, :month, :string
    remove_column :bgit_invoicing_invoices, :year, :string
  end
end
