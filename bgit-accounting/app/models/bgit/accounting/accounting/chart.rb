module Bgit::Accounting
  class Accounting::Chart < ApplicationRecord
    has_many :account_categories

    validates :identifier, presence: true, uniqueness: true
    validates :label, presence: true, uniqueness: true
  end
end
