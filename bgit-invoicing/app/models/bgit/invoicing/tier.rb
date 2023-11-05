module Bgit::Invoicing
  class Tier < ApplicationRecord
    include MoneyRails::ActionViewExtension

    belongs_to :product

    monetize :price_per_month_cents, with_currency: Bgit::Invoicing::Configuration.default_currency
    monetize :price_per_second_cents, with_currency: Bgit::Invoicing::Configuration.default_currency

    validates :identifier, presence: true, uniqueness: {scope: :product_id}, identifier: true
    validates :price_per_month_cents, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :available_from, presence: true
    validates :available_to, presence: true

    def human
      "#{product.identifier} - #{identifier} (#{humanized_money(price_per_month, symbol: true)})"
    end

    def price_per_second_cents(year: nil, month: nil)
      return if price_per_month_cents.nil?
      price_per_month_cents.to_f / days_in_month(year: year, month: month).days.to_f
    end

    def days_in_month(year: nil, month: nil)
      return 30 if [year, month].any?(&:nil?)
      Date.new(year.to_i, month.to_i, -1).day
    end
  end
end
