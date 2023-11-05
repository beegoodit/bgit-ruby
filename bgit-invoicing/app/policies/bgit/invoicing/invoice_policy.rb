module Bgit
  module Invoicing
    class InvoicePolicy < ApplicationPolicy
      def index?
        true
      end

      def show?
        # allow when the invoice is owned by the user
        return true if user = record.owner

        # allow when the invoice is owned by any of the user's teams
        return true if user.teams.include?(record.owner)

        # else do not allow
        false
      end
    end
  end
end
