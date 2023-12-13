module Bgit::Invoicing
  class BilledItem < ApplicationRecord
    belongs_to :line_item
    belongs_to :billable, polymorphic: true
  end
end
