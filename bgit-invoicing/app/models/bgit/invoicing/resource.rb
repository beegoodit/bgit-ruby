module Bgit::Invoicing
  class Resource < ApplicationRecord
    belongs_to :product
    belongs_to :owner, polymorphic: true
    has_many :subscriptions, dependent: :restrict_with_error

    validates :identifier, presence: true, uniqueness: {scope: :product_id}

    def human
      "#{product.identifier} - #{identifier}"
    end
  end
end
