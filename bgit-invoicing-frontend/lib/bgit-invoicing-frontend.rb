require "bgit-invoicing"
require "bgit-frontend_auth-frontend"
require "pundit"
require "rao-component"
require "turbo-rails"

require "bgit/invoicing/frontend/version"
require "bgit/invoicing/frontend/configuration"
require "bgit/invoicing/frontend/engine"

module Bgit
  module Invoicing
    module Frontend
      def self.configure
        yield Configuration
      end
    end
  end
end
