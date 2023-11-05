module Bgit
  module Invoicing
    class GenerateInvoiceForOwnerService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :invoice, :line_items, :resources, :subscriptions
      end

      attr_accessor :owner, :year, :month

      # additional accessors for forms
      attr_accessor :owner_id, :owner_type

      validates :owner, presence: true
      validates :year, presence: true
      validates :month, presence: true

      # validate that there are no overlapping invoices
      validate do
        if Bgit::Invoicing::Invoice.where(owner: owner).where(year: year).where(month: month).exists?
          errors.add(:base, :overlapping_invoice)
        end
      end

      def from
        @from ||= Time.zone.local(year, month, 1).beginning_of_month
      end

      def to
        @to ||= from.end_of_month
      end

      def owner
        @owner ||= owner_type.constantize.find(owner_id)
      end

      def year=(value)
        @year = value.to_i
      end

      def month=(value)
        @month = value.to_i
      end

      private

      def _perform
        @result.invoice = invoice
        @result.line_items = line_items
        @result.subscriptions = line_items.collect(&:subscription)
        @result.resources = line_items.collect(&:subscription).collect(&:resource)
        @result.invoice.total_price = total_price
      end

      def save
        ActiveRecord::Base.transaction do
          invoice.save!
          line_items.each(&:save!)
        end
      end

      def resources
        @resources ||= Bgit::Invoicing::Resource
          .where(owner: owner)
      end

      def subscriptions
        @subscriptions ||= Bgit::Invoicing::Subscription
          .where(resource: resources)
          .where("active_from <= ?", to)
          .where("active_to >= ?", from)
      end

      def invoice
        @invoice ||= Bgit::Invoicing::Invoice.new(
          owner: owner,
          year: year,
          month: month
        )
      end

      def line_items
        @line_items ||= subscriptions.collect do |subscription|
          Bgit::Invoicing::LineItem.new(
            invoice: invoice,
            subscription: subscription,
            seconds: seconds_for_subscription(subscription),
            price_cents: price_for_subscription_cents(subscription)
          )
        end
      end

      def seconds_for_subscription(subscription)
        # calculate the overlap of from and to with active_from and active_to
        active_from = [from, subscription.active_from].max
        active_to = [to, subscription.active_to].min

        # take the overlap in seconds
        overlap = active_to - active_from

        # return 0 if there is no overlap
        return 0 if overlap <= 0

        # calculate and return the seconds in the overlap
        overlap.to_i
      end

      def price_for_subscription_cents(subscription)
        seconds = seconds_for_subscription(subscription)
        return 0 if seconds <= 0

        [
          subscription.tier.price_per_month_cents,
          (seconds * subscription.tier.price_per_second_cents(year: year, month: month)).round
        ].min
      end

      def price_for_subscription(subscription)
        Money.new(price_for_subscription_cents(subscription), Bgit::Invoicing::Configuration.default_currency)
      end

      def total_price
        @total_price ||= Money.new(line_items.sum(&:price_cents), Bgit::Invoicing::Configuration.default_currency)
      end
    end
  end
end
