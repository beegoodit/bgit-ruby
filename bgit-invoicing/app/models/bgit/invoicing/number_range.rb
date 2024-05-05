module Bgit::Invoicing
  class NumberRange < ApplicationRecord
    validates :identifier, presence: true, uniqueness: true
    validates :next_value, presence: true, numericality: {greater_than_or_equal_to: 1}
    validates :format, presence: true
    validates :minimum_length, presence: true, numericality: {greater_than_or_equal_to: 1}
    validates :prefix, presence: true, uniqueness: true

    after_initialize :set_defaults, if: :new_record?

    def next_formatted_value
      "#{prefix}#{Time.zone.now.strftime(format)}#{next_value.to_s.rjust(minimum_length, "0")}"
    end

    private

    def set_defaults
      self.next_value ||= 1
      self.format ||= "%Y%m-"
      self.minimum_length ||= 4
    end
  end
end
