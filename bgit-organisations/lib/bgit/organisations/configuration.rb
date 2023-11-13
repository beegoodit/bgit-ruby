module Bgit
  module Organisations
    class Configuration
      class << self
        extend Forwardable

        attr_accessor :values

        def define_option(key, default: nil)
          @values[key] = default
          define_singleton_method(key) do
            @values[key]
          end

          define_singleton_method("#{key}=") do |value|
            @values[key] = value
          end
        end

        def cmor
          Cmor
        end
      end

      @values = {}

      define_option :resources_controllers, default: -> {
        [
          Bgit::Organisations::TeamsController
        ]
      }
      define_option :resource_controllers, default: -> { [] }
      define_option :service_controllers, default: -> { [] }
      define_option :sidebar_controllers, default: -> { [] }

      define_option :team_member_class_name, default: "User"
      define_option :team_member_factory_name, default: :user
      define_option :team_membership_member_foreign_key_to_table, default: "users"
    end
  end
end
