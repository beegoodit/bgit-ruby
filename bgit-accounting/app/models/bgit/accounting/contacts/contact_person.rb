module Bgit::Accounting
  class Contacts::ContactPerson < ApplicationRecord
    include Bgit::Accounting::Model::UuidConcern

    belongs_to :company

    validates :salutation, presence: true
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :primary, inclusion: {in: [true, false]}

    def human
      "#{salutation} #{firstname} #{lastname}"
    end
  end
end
