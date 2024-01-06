require "csv"
require "cocoon"
require "httparty"
require "keepr"
require "money-rails"
require "simple_form-polymorphic_associations"

require "bgit/accounting/version"
require "bgit/accounting/engine"
require "bgit/accounting/configuration"

module Bgit
  module Accounting
    def self.configure
      yield Configuration
    end
  end
end
