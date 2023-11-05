require "aasm"
require "after_commit_everywhere"
require "bgit-frontend_auth"
require "json_seeds-rails"
require "lexoffice_client"
require "money-rails"
require "pundit"
require "simple_form-datetimepicker"
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
