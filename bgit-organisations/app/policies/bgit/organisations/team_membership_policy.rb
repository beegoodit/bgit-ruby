module Bgit::Organisations
  class TeamMembershipPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        # define the scope to only include records of the teams the user is a member of
        scope.where(team_id: user.teams.pluck(:id))
      end
    end

    def index?
      true
    end
  end
end
