require "rails_helper"

RSpec.describe "/de/backend/lexoffice/invoices", type: :feature do
  let(:resource_class) { Bgit::Lexoffice::Invoice }
  let(:resource) { create(:bgit_lexoffice_invoice) }
  let(:resources) { create_list(:bgit_lexoffice_invoice, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_invoice") {
        # fill the needed form inputs via capybara here
        fill_in "invoice[lexoffice_id]", with: "12345"
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
