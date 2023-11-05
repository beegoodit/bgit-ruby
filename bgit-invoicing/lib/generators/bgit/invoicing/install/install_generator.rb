module Bgit
  module Invoicing
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Generates the initializer"

        source_root File.expand_path("../templates", __FILE__)

        attr_accessor :resource_owner_factory_name, :invoice_owner_factory_name

        def initialize(*args)
          super
          @resource_owner_factory_name = ENV.fetch("BGIT_INVOICING_RESOURCE_OWNER_FACTORY_NAME", "user")
          @invoice_owner_factory_name = ENV.fetch("BGIT_INVOICING_INVOICE_OWNER_FACTORY_NAME", "user")
        end

        def generate_initializer
          template "initializer.rb", "config/initializers/bgit-invoicing.rb"
        end

        def generate_routes
          route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
        end
      end
    end
  end
end
