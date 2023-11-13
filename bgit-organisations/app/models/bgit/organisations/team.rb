module Bgit::Organisations
  class Team < ApplicationRecord
    include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern

    autocomplete scope: ->(matcher) { where("lower(bgit_organisations_teams.name) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

    has_many :team_memberships, inverse_of: :team, dependent: :destroy
    has_many :members, through: :team_memberships
    if Object.const_defined?("Bgit::Hosting")
      has_many :apps, inverse_of: :owner, as: :owner, dependent: :nullify, class_name: "Bgit::Hosting::App"
    end

    if Object.const_defined?("Bgit::Lexoffice")
      has_one :lexoffice_contact, as: :contactable, class_name: "Bgit::Lexoffice::Contact", dependent: :restrict_with_error
    end

    validates :name, presence: true, uniqueness: true

    def human
      name
    end
  end
end
