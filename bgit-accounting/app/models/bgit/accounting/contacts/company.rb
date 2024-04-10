module Bgit::Accounting
  class Contacts::Company < ApplicationRecord
    include Bgit::Accounting::Model::UuidConcern

    belongs_to :contact
    has_many :addresses
    has_many :contact_people
    has_many :email_addresses
    has_many :phone_numbers

    accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :contact_people, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :email_addresses, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: :all_blank
  end
end
