module Bgit
  module Organisations
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Generates the initializer"

        source_root File.expand_path("../templates", __FILE__)

        attr_reader :team_member_class_name,
          :team_member_factory_name,
          :team_membership_member_foreign_key_to_table

        def initialize(*args)
          super
          @team_member_class_name = ENV.fetch("BGIT_ORGANISATIONS_TEAM_MEMBER_CLASS_NAME") { "Bgit::FrontendAuth::User" }
          @team_member_factory_name = ENV.fetch("BGIT_ORGANISATIONS_TEAM_MEMBER_FACTORY_NAME") { "bgit_frontend_auth_user" }
          @team_membership_member_foreign_key_to_table = ENV.fetch("BGIT_ORGANISATIONS_TEAM_MEMBERSHIP_MEMBER_FOREIGN_KEY_TO_TABLE") { "bgit_frontend_auth_users" }
        end

        def generate_initializer
          template "initializer.rb", "config/initializers/bgit-organisations.rb"
        end

        def generate_routes
          route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
        end
      end
    end
  end
end
