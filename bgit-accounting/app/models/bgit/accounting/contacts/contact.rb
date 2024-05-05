module Bgit::Accounting
  class Contacts::Contact < ApplicationRecord
    include Bgit::Accounting::Model::UuidConcern

    has_one :company
    has_one :person
    has_many :roles

    accepts_nested_attributes_for :company
    accepts_nested_attributes_for :person

    validates :person, absence: true, if: -> { company.present? }
    validates :company, absence: true, if: -> { person.present? }
    validates :name, presence: true
  end
end
