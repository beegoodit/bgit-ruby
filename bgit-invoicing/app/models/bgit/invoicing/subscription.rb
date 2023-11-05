module Bgit::Invoicing
  class Subscription < ApplicationRecord
    belongs_to :tier
    belongs_to :resource
    has_one :owner, through: :resource

    validates :active_from, presence: true
    validates :active_to, presence: true

    scope :active_at, ->(month, year) do
      active_between(Time.zone.local(year, month, 1).beginning_of_month, Time.zone.local(year, month, 1).end_of_month)
    end

    scope :owned_by, ->(owner) do
      joins(:resource).where(bgit_invoicing_resources: {owner: owner})
    end

    scope :active_between, ->(from, to) do
      where("active_from <= ? AND active_to >= ?", to, from)
    end

    def human
      "#{tier.human} - #{resource.identifier}"
    end

    def owner
      resource.owner
    end
  end
end
