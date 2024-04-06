module Bgit::Accounting
  class Accounting::AccountableChart < ApplicationRecord
    belongs_to :accountable, polymorphic: true
    belongs_to :chart

    module ActiveConcern
      extend ActiveSupport::Concern

      included do
        validates :active_from, presence: true
        validates :active_to, presence: true

        after_initialize :set_active_defaults, if: :new_record?

        scope :active_at, ->(point_in_time) { where("active_from <= :point_in_time AND active_to >= :point_in_time", point_in_time: point_in_time.to_date) }
        scope :active_now, -> { active_at(Time.zone.now) }
      end

      private

      def set_active_defaults
        self.active_from ||= Date.new(1970, 1, 1)
        self.active_to ||= Date.new(9999, 12, 31)
      end
    end

    include ActiveConcern
  end
end
