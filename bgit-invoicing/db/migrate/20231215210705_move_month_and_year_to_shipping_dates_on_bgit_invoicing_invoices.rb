class MoveMonthAndYearToShippingDatesOnBgitInvoicingInvoices < ActiveRecord::Migration[7.0]
  def up
    ActiveRecord::Base.transaction do
      Bgit::Invoicing::Invoice.all.each do |invoice|
        invoice.shipping_date = Time.parse("#{invoice.year}-#{invoice.month}-01")
        invoice.shipping_end_date = invoice.shipping_date.end_of_month
        invoice.save!
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Bgit::Invoicing::Invoice.all.each do |invoice|
        invoice.year = invoice.shipping_date.year
        invoice.month = invoice.shipping_date.month
        invoice.save!
      end
    end
  end
end
