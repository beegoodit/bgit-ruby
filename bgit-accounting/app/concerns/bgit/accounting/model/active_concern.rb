module Bgit
  module Accounting
    module Model
      module ActiveConcern
        extend ActiveSupport::Concern

        included do
          validates :active_from, presence: true
          validates :active_to, presence: true

          scope :active, -> { active_at(Time.zone.now) }
          scope :active_at, ->(point_in_time) {
            t = arel_table
            where(t[:active_from].lteq(point_in_time)).where(t[:active_to].gteq(point_in_time))
          }

          after_initialize do
            self.active_from ||= Time.at(0)
            self.active_to ||= Time.new(9999, 12, 31, 23, 59, 59)
          end
        end
      end
    end
  end
end
