require "rails_helper"

RSpec.describe "/de/backend/organisationen/team_memberships", type: :feature do
  let(:resource_class) { Bgit::Organisations::TeamMembership }
  let(:resource) { create(:bgit_organisations_team_membership) }
  let(:resources) { create_list(:bgit_organisations_team_membership, 3) }

  let(:user) { create(:bgit_frontend_auth_user) }
  let(:team) { create(:bgit_organisations_team) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    team
    user
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_team_membership") {
        select user.email, from: "team_membership[member_id]"
        select team.name, from: "team_membership[team_id]"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    new_user = create(:bgit_frontend_auth_user, email: "new-user@domain.local")
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_team_membership") {
        select new_user.email, from: "team_membership[member_id]"
      }
      .updating
      .from(resource.attributes)
      .to({"member_id" => new_user.id})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
