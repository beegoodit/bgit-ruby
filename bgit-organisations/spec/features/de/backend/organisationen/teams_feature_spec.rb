require "rails_helper"

RSpec.describe "/de/backend/organisationen/teams", type: :feature do
  let(:resource_class) { Bgit::Organisations::Team }
  let(:resource) { create(:bgit_organisations_team) }
  let(:resources) { create_list(:bgit_organisations_team, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_team") {
        fill_in "team[name]", with: "Team #1"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_team") {
        fill_in "team[name]", with: "New Name"
      }
      .updating
      .from(resource.attributes)
      .to({"name" => "New Name"})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
