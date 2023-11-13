FactoryBot.define do
  factory :bgit_organisations_team, class: Bgit::Organisations::Team do
    sequence(:name) { |i| "Team #{i}" }
  end
end
