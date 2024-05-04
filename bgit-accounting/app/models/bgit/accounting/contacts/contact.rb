module Bgit::Accounting
  class Contacts::Contact < ApplicationRecord
    include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern
    include Bgit::Accounting::Model::UuidConcern

    has_one :company, dependent: :destroy
    has_one :person, dependent: :destroy
    has_many :roles, dependent: :destroy

    has_one :customer_account, -> { where(kind: "debtor") }, class_name: "Bgit::Accounting::Accounting::Account", as: :accountable, dependent: :destroy
    has_one :supplier_account, -> { where(kind: "creditor") }, class_name: "Bgit::Accounting::Accounting::Account", as: :accountable, dependent: :destroy

    accepts_nested_attributes_for :company, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :person, allow_destroy: true, reject_if: :all_blank

    accepts_nested_attributes_for :customer_account, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :supplier_account, allow_destroy: true, reject_if: :all_blank

    validates :person, absence: true, if: -> { company.present? }
    validates :company, absence: true, if: -> { person.present? }
    validates :name, presence: true

    autocomplete scope: ->(matcher) { where("lower(name) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

    scope :customers, -> { joins(:customer_account) }
    scope :suppliers, -> { joins(:supplier_account) }

    def human
      name
    end
  end
end
