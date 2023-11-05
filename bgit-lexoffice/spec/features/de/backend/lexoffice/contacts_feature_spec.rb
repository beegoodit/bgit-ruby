require "rails_helper"

RSpec.describe "/de/backend/lexoffice/contacts", type: :feature do
  let(:resource_class) { Bgit::Lexoffice::Contact }
  let(:resource) { create(:bgit_lexoffice_contact) }
  let(:resources) { create_list(:bgit_lexoffice_contact, 3) }

  let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }

  before(:each) do
    # set autocomplete classes
    allow(Bgit::Lexoffice::Configuration).to receive(:contact_contactable_autocomplete_classes).and_return(-> {
      {Bgit::FrontendAuth::User => bgit_frontend_auth.url_for([:autocomplete, Bgit::FrontendAuth::User])}
    })
  end

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  describe "Create", type: :system, js: true do
    it {
      bgit_frontend_auth_user
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("body") {
          # fill the needed form inputs via capybara here
          select bgit_frontend_auth_user.class.model_name.human, from: "contact[contactable_type]"
          first(".select2-container", minimum: 1).click
          find(".select2-search--dropdown input.select2-search__field").send_keys(bgit_frontend_auth_user.human)
          sleep(1)
          find(".select2-search--dropdown input.select2-search__field").send_keys(:enter)

          fill_in "contact[lexoffice_id]", with: "47b5ba15-0edc-42c0-9b9d-343422ba6d1b"
        }
        .increasing {
                           sleep(1)
                           resource_class.count
                         }.by(1)
    }
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_contact") {
        # fill the needed form inputs via capybara here
        fill_in "contact[lexoffice_id]", with: "12345"
      }
      .updating
      .from(resource.attributes)
      .to({"lexoffice_id" => "12345"})
  }

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
