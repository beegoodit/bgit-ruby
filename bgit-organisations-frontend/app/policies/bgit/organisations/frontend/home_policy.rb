module Bgit
  module Organisations
    module Frontend
      class HomePolicy
        attr_reader :user, :record

        def initialize(user, record)
          @user = user
          @record = record
        end

        def index?
          true
        end
      end
    end
  end
end
