require "aasm"
require "after_commit_everywhere"
require "bgit-frontend_auth"
require "cmor-core-settings"
require "cocoon"
require "json_seeds-rails"
require "lexoffice_client"
require "money-rails"
require "pundit"
require "simple_form-datetimepicker"
require "simple_form-polymorphic_associations"
require "turbo-rails"

require "bgit/invoicing/version"
require "bgit/invoicing/configuration"
require "bgit/invoicing/engine"

module Bgit
  module Invoicing
    def self.configure
      yield Configuration
    end
  end
end
