require "bgit-frontend_auth"
require "simple_form"
require "route_translator"
require "rao-component"
require "rao-resources_controller"
require "rao-service"
require "haml-rails"
require "route_translator"

require "bgit/frontend_auth/frontend/configuration"
require "bgit/frontend_auth/frontend/engine"

module Bgit
  module FrontendAuth
    module Frontend
      extend Configuration
    end
  end
end
