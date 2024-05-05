module Bgit::Accounting
  class Contacts::EmailAddress < ApplicationRecord
    include Bgit::Accounting::Model::HumanValueNameConcern
    include Bgit::Accounting::Model::UuidConcern

    ROLES = %w[business office private other].freeze

    belongs_to :company

    validates :email, presence: true
    validates :role, presence: true, uniqueness: {scope: :company_id}, inclusion: {in: ROLES}
  end
end
