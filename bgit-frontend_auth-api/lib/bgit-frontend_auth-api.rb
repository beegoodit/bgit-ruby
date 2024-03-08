require "bgit-frontend_auth"
require "jwt"

require "bgit/frontend_auth/api/configuration"
require "bgit/frontend_auth/api/engine"

module Bgit
  module FrontendAuth
    module Api
      extend Configuration
    end
  end
end
