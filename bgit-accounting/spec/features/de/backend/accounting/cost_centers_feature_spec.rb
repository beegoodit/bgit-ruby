require "rails_helper"

RSpec.describe "/de/backend/accounting/cost_centers", type: :feature do
  let(:resource_class) { Keepr::CostCenter }

  describe "REST actions" do
    let(:resource) { create(:cost_center) }
    let(:resources) {
      build_list(:cost_center, 3) { |record, index|
        record.number = "100#{index}"
        record.save!
      }
    }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    it {
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("#new_keepr_cost_center") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     select 'de', from: 'slider[locale]'
          #     fill_in 'slider[name]', with: 'My first slider'
          #     check 'slider[auto_start]'
          #     fill_in 'slider[interval]', with: '3'
          fill_in "keepr_cost_center[number]", with: "1000"
          fill_in "keepr_cost_center[name]", with: "Bank"
        }
        .increasing { resource_class.count }.by(1)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_keepr_cost_center") {
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
