module Bgit::Invoicing
  class Product < ApplicationRecord
    has_many :tiers, dependent: :destroy
    has_many :resources, dependent: :restrict_with_error

    validates :identifier, presence: true, uniqueness: true, identifier: true

    def human
      identifier
    end
  end
end
