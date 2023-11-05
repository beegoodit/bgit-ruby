module Bgit
  module Invoicing
    class BillingRunService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :month, :year, :owners, :active_subscriptions, :invoices, :invoices_count, :total_price
      end

      attr_accessor :month, :year, :owners

      validates :month, presence: true
      validates :year, presence: true

      private

      def _perform
        @result.month = month
        @result.year = year
        @result.owners = owners
        @result.active_subscriptions = active_subscriptions

        @result.invoices = generate_invoices || []

        @result.invoices_count = @result.invoices.count
        @result.total_price = @result.invoices.sum(&:total_price)
      end

      def generate_invoices
        ActiveRecord::Base.transaction do
          @owners.map do |owner|
            # skip owners that were created after the billing run
            if owner.created_at > Time.zone.local(year, month, 1).end_of_month
              say "Skipping owner #{owner.human} because it was created after the billing run."
            end

            result = Bgit::Invoicing::GenerateInvoiceForOwnerService.call!(
              owner: owner,
              month: month,
              year: year
            )
            if result.ok?
              result.invoice
            else
              errors.add(:base, :failed_to_generate_invoice_for_owner, owner: owner.human, errors: result.errors.full_messages.to_sentence)
              raise ActiveRecord::Rollback
              nil
            end
          end.compact
        end
      end

      def active_subscriptions
        @active_subscriptions ||= Bgit::Invoicing::Subscription
          .active_at(month, year)
          .includes(:resource).where(bgit_invoicing_resources: {owner: owners})
      end

      def owners
        @owners ||= Bgit::Invoicing::Resource.pluck(:owner_type).uniq.map(&:constantize).map(&:all).flatten
      end
    end
  end
end
