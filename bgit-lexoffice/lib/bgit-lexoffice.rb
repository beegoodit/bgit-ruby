require "cmor-core-backend"
require "rao-service"
require "simple_form-polymorphic_associations"
require "httparty"
require "turbo-rails"
require "pundit"
require "bgit-invoicing"
require "lexoffice_client"

require "bgit/lexoffice/version"
require "bgit/lexoffice/configuration"
require "bgit/lexoffice/engine"

module Bgit
  module Lexoffice
    def self.configure
      yield Configuration
    end
  end
end
