module Bgit::Lexoffice
  class Invoice < ApplicationRecord
    belongs_to :invoiceable, polymorphic: true, optional: true

    validates :lexoffice_id, presence: true, uniqueness: true

    has_one_attached :lexoffice_document

    def human
      [lexoffice_id, invoiceable&.human].compact.join(" - ")
    end
  end
end
