module Bgit::Accounting
  class Contacts::Address < ApplicationRecord
    include Bgit::Accounting::Model::HumanValueNameConcern
    include Bgit::Accounting::Model::UuidConcern

    ROLES = %w[billing shipping].freeze

    belongs_to :company

    validates :street, presence: true
    validates :zip_code, presence: true
    validates :city, presence: true
    validates :country_code, presence: true
    validates :role, presence: true, uniqueness: {scope: :company_id}, inclusion: {in: ROLES}
  end
end
