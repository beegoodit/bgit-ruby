require "rails_helper"

RSpec.describe "/de/backend/lexoffice/contact/read_services", type: :feature, vcr: true do
  let(:base_path) { "/de/backend/lexoffice/contact/read_services" }

  before(:each) do
    expect(LexofficeClient::Configuration).to receive(:api_token).and_return("n2.o0c.raladGqUDySbv9ZKZaNKME0pf7W3YulfNjlaTV1TC")
  end

  describe "basic usage" do
    let(:contact) { create(:bgit_lexoffice_contact, lexoffice_id: "f46f7930-53df-48b0-b2cc-39a9f7ad6c7f") }
    let(:new_path) { "#{base_path}/new" }

    before(:each) do
      contact
      visit(new_path)

      select(contact.lexoffice_id, from: "contact_read_service[contact_id]")
    end

    describe "UI" do
      before(:each) do
        find("input[type='submit']").click
      end

      it { expect(page).to have_current_path(base_path) }
      it { expect(page).to have_content("Kontaktlesedienst wurde ausgeführt.") }
    end
  end
end
