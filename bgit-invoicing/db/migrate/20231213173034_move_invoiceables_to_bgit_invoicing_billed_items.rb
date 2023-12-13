class MoveInvoiceablesToBgitInvoicingBilledItems < ActiveRecord::Migration[7.0]
  class Bgit::Invoicing::LineItem
    belongs_to :invoice, inverse_of: :line_items
    belongs_to :invoiceable, polymorphic: true
    has_many :billed_items, inverse_of: :line_item, dependent: :destroy
    has_many :billables, through: :billed_items
  end

  class Bgit::Invoicing::BilledItem
    belongs_to :line_item, inverse_of: :billed_items
    belongs_to :billable, polymorphic: true
  end

  def up
    ActiveRecord::Base.transaction do
      Bgit::Invoicing::LineItem.all.each do |line_item|
        Bgit::Invoicing::BilledItem.create!(line_item: line_item, billable: line_item.invoiceable)
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Bgit::Invoicing::LineItem.all.each do |line_item|
        line_item.invoiceable = line_item.billed_items.first.billable
        line_item.save!
      end
    end
  end
end
