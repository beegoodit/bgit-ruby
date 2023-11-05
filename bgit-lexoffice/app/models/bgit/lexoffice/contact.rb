module Bgit::Lexoffice
  class Contact < ApplicationRecord
    belongs_to :contactable, polymorphic: true, optional: true

    validates :lexoffice_id, presence: true, uniqueness: true

    def human
      [lexoffice_id, contactable&.human].compact.join(" - ")
    end
  end
end
