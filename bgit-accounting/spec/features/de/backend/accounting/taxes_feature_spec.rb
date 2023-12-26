require "rails_helper"

RSpec.describe "/de/backend/accounting/taxes", type: :feature do
  let(:resource_class) { Keepr::Tax }

  describe "REST actions" do
    let(:resource) { create(:tax) }
    let(:resources) { create_list(:tax, 3) }

    let(:account) { create(:account) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    it {
      account
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("#new_keepr_tax") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     select 'de', from: 'slider[locale]'
          #     fill_in 'slider[name]', with: 'My first slider'
          #     check 'slider[auto_start]'
          #     fill_in 'slider[interval]', with: '3'
          fill_in "keepr_tax[name]", with: "My first tax"
          fill_in "keepr_tax[value]", with: "19.0"
          select account.to_s, from: "keepr_tax[keepr_account_id]"
        }
        .increasing { resource_class.count }.by(1)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_keepr_tax") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     fill_in 'slider[name]', with: 'New name'
        }
        .updating
        .from(resource.attributes)
        .to({}) # Example: .to({ 'name' => 'New name' })
    }

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing { resource_class.count }.by(1)
    }
  end
end
