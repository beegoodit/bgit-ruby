FactoryBot.define do
  factory :bgit_organisations_team_membership, class: Bgit::Organisations::TeamMembership do
    association(:member, factory: Bgit::Organisations::Configuration.team_member_factory_name)
    association(:team, factory: :bgit_organisations_team)
  end
end
