Rails.application.config.to_prepare do
  Bgit::Organisations::Configuration.team_member_class_name.constantize.send(
    :has_many,
    :team_memberships,
    class_name: "Bgit::Organisations::TeamMembership",
    inverse_of: :member,
    foreign_key: :member_id
  )

  Bgit::Organisations::Configuration.team_member_class_name.constantize.send(
    :has_many,
    :teams,
    through: :team_memberships,
    class_name: "Bgit::Organisations::Team",
    inverse_of: :members
  )
  puts "[Bgit::Organisations] Injected associations into #{Bgit::Organisations::Configuration.team_member_class_name}."
rescue NameError => e
  puts "[Bgit::Organisations] Class #{Bgit::Organisations::Configuration.team_member_class_name} not found. Skipping association."
end
