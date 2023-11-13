module Bgit::Organisations
  class TeamMembership < ApplicationRecord
    belongs_to :member, inverse_of: :team_memberships, class_name: Bgit::Organisations::Configuration.team_member_class_name, foreign_key: :member_id
    belongs_to :team, inverse_of: :team_memberships

    validates :member, presence: true
    validates :team, presence: true
    validates :member_id, uniqueness: {scope: :team_id}

    def human
      "#{team.human}: #{member.human}"
    end
  end
end
