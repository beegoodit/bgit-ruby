module Bgit::Accounting
  class Contacts::Person < ApplicationRecord
    include Bgit::Accounting::Model::UuidConcern

    belongs_to :contact

    validates :salutation, presence: true
    validates :firstname, presence: true
    validates :lastname, presence: true

    def human
      "#{salutation} #{firstname} #{lastname}"
    end
  end
end
