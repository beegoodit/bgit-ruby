module Bgit
  module Invoicing
    class LineItemsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Bgit::Invoicing::LineItem
      end

      private

      def permitted_params
        params.require(:line_item).permit(
          :description,
          :invoice_id,
          :name,
          :quantity,
          :tax_rate_percentage,
          :unit_name,
          :unit_net_amount_cents,
          billed_items_attributes: [
            :id,
            :_destroy,
            :billable_id,
            :billable_type
          ]
        )
      end
    end
  end
end
