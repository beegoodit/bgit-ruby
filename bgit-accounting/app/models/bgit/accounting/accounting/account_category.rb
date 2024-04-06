module Bgit::Accounting
  class Accounting::AccountCategory < ApplicationRecord
    belongs_to :chart
    has_many :accounts

    enum side: {income: 0, expense: 1}

    validates :identifier, presence: true, uniqueness: true
    validates :label, presence: true, uniqueness: true
    validates :side, presence: true, inclusion: {in: %w[income expense]}

    scope :income, -> { where(side: :income) }
    scope :expense, -> { where(side: :expense) }

    def human
      "#{label} (#{side})"
    end
  end
end
