require "bgit-frontend_auth-frontend"
require "bgit-organisations"
require "pundit"
require "rao-component"
require "turbo-rails"

require "bgit/organisations/frontend/version"
require "bgit/organisations/frontend/configuration"
require "bgit/organisations/frontend/engine"

module Bgit
  module Organisations
    module Frontend
      def self.configure
        yield Configuration
      end
    end
  end
end
