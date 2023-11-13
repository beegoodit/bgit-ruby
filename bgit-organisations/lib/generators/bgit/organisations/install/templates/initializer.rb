Bgit::Organisations.configure do |config|
  config.cmor.administrador.register_engine("Bgit::Organisations::Engine", {})

  # Set the resources, that will be shown in the backend menu.
  #
  # Default: config.resources_controllers = -> {[
  #            Bgit::Organisations::TeamsController,
  #            Bgit::Organisations::TeamMembershipsController
  #          ]}
  #
  config.resources_controllers = -> {
    [
      Bgit::Organisations::TeamsController,
      Bgit::Organisations::TeamMembershipsController
    ]
  }

  # Set the singular resources, that will be shown in the backend menu.
  #
  # Default: config.resource_controllers = -> {[
  #          ]}
  #
  config.resource_controllers = -> {
    []
  }

  # Set the services, that will be shown in the backend menu.
  #
  # Default: config.service_controllers = -> {[
  #          ]}
  #
  config.service_controllers = -> {
    []
  }

  # Set the sidebars, that will be shown in the backend menu.
  #
  # Default: config.sidebar_controllers = -> {[
  #          ]}
  #
  config.sidebar_controllers = -> {
    []
  }

  # Set the class name for the member association on team memberships.
  #
  # Default: config.team_member_class_name = '<%= team_member_class_name %>'
  #
  config.team_member_class_name = "<%= team_member_class_name %>"

  # Set the factory name for the member association on team memberships.
  #
  # Default: config.team_member_factory_name = :<%= team_member_factory_name %>
  #
  config.team_member_factory_name = :<%= team_member_factory_name %>

  # Set the foreign key options for the member association on team memberships.
  #
  # Default: config.team_membership_member_foreign_key_to_table = "<%= team_membership_member_foreign_key_to_table %>"
  #
  config.team_membership_member_foreign_key_to_table = "<%= team_membership_member_foreign_key_to_table %>"
end
