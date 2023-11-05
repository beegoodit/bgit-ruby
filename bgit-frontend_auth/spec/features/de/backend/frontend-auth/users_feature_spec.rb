require "rails_helper"

RSpec.describe "/de/backend/frontend-auth/users", type: :feature do
  let(:resource_class) { Bgit::FrontendAuth::User }
  let(:resource) { create(:bgit_frontend_auth_user) }
  let(:resources) { create_list(:bgit_frontend_auth_user, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_user") {
        fill_in "user[email]", with: "jane.doe@domain.local"
        fill_in "user[password]", with: "Test1234!"
        fill_in "user[password_confirmation]", with: "Test1234!"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_user") {
        fill_in "user[email]", with: "jane.doe2@domain.local"
      }
      .updating
      .from(resource.attributes)
      .to({"email" => "jane.doe2@domain.local"})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
