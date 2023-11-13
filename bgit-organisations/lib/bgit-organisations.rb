require "bgit-frontend_auth"
require "cmor-core-backend"

require "bgit/organisations/configuration"
require "bgit/organisations/engine"
require "bgit/organisations/version"

module Bgit
  module Organisations
    def self.configure
      yield Configuration
    end
  end
end
