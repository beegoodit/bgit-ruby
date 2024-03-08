module Bgit
  module FrontendAuth
    module Api
      module Configuration
        def configure
          yield self
        end

        mattr_accessor :base_controller, default: "ActionController::API"
        mattr_accessor :enable_registrations, default: false
      end
    end
  end
end
