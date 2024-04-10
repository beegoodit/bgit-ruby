module Bgit::Accounting
  class Contacts::Role < ApplicationRecord
    include Bgit::Accounting::Model::UuidConcern

    belongs_to :contact

    validates :number, presence: true
    validates :identifier, presence: true, uniqueness: {scope: :contact_id}, inclusion: {in: %w[customer vendor]}
  end
end
