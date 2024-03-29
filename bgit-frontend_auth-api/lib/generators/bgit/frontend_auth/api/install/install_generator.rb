module Bgit
  module FrontendAuth
    module Api
      class InstallGenerator < Rails::Generators::Base
        desc 'Installs Bgit::FrontendAuth::Api'

        source_root File.expand_path('../templates', __FILE__)

        attr_reader :base_controller_class_name

        def initialize(*args)
          super
          @base_controller_class_name = ENV.fetch('BGIT_FRONTEND_API_BASE_CONTROLLER_CLASS_NAME') { '::ApplicationController' }
        end

        def generate_initializer
          template 'initializer.rb', 'config/initializers/bgit-frontend_auth-api.rb'
        end

        def generate_routes
          route File.read(File.join(File.expand_path('../templates', __FILE__), 'routes.source'))
        end
      end
    end
  end
end
