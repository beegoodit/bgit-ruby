module Bgit::Accounting
  class Contacts::PhoneNumber < ApplicationRecord
    include Bgit::Accounting::Model::HumanValueNameConcern
    include Bgit::Accounting::Model::UuidConcern

    ROLES = %w[business office mobile private fax other].freeze

    belongs_to :company

    validates :number, presence: true
    validates :role, presence: true, uniqueness: {scope: :company_id}, inclusion: {in: ROLES}
  end
end
