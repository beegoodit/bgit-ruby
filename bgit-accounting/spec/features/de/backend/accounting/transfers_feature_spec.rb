require "rails_helper"

RSpec.describe "/de/backend/accounting/transfers", type: :feature do
  let(:resource_class) { Bgit::Accounting::Transfer }

  describe "REST actions" do
    let(:resource) { create(:bgit_accounting_transfer) }
    let(:resources) { create_list(:bgit_accounting_transfer, 3) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    describe "Create", type: :system do
      let(:from_bank_account) { create(:bgit_accounting_bank_account) }
      let(:to_bank_account) { create(:bgit_accounting_bank_account) }

      before(:each) do
        from_bank_account
        to_bank_account
      end

      it {
        expect(subject).to implement_create_action(self)
          .for(resource_class)
          .within_form("#new_transfer") {
            # fill the needed form inputs via capybara here
            #
            # Example:
            #
            #     select 'de', from: 'slider[locale]'
            #     fill_in 'slider[name]', with: 'My first slider'
            #     check 'slider[auto_start]'
            #     fill_in 'slider[interval]', with: '3'
            select(from_bank_account.human, from: "transfer[sender_bank_account_id]")
            select(to_bank_account.human, from: "transfer[recipient_bank_account_id]")
            fill_in "transfer[amount]", with: "100,00"
          }
          .increasing { resource_class.count }.by(1)
      }
    end

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_transfer") {
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
