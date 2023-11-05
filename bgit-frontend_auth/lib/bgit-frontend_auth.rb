require "authlogic"
require "scrypt"
require "cmor-core-backend"
require "simple_form-polymorphic_associations"

require "bgit/frontend_auth/configuration"
require "bgit/frontend_auth/engine"
require "bgit/frontend_auth/version"

module Bgit
  module FrontendAuth
    def self.configure
      yield Configuration
    end
  end
end
