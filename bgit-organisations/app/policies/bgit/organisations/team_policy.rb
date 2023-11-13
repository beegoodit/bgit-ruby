module Bgit::Organisations
  class TeamPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      # allow when the team if the user is a member of the team
      @record.members.include?(@user)
    end
  end
end
