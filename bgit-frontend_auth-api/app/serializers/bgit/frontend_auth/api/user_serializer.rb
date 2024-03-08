module Bgit
  module FrontendAuth
    module Api
      class UserSerializer
        def initialize(user)
          @user = user
        end

        def as_json(options = {})
          {
            id: @user.id,
            email: @user.email
          }
        end
      end
    end
  end
end
