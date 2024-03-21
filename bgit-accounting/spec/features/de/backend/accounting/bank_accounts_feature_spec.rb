require "rails_helper"

RSpec.describe "/de/backend/accounting/bank_accounts", type: :feature do
  let(:resource_class) { Bgit::Accounting::BankAccount }

  describe "REST actions" do
    let(:resource) { create(:bgit_accounting_bank_account) }
    let(:resources) { create_list(:bgit_accounting_bank_account, 3) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    describe "Create", type: :system do
      let(:accountable) { create(:user) }

      it {
        expect(subject).to implement_create_action(self)
          .for(resource_class)
          .within_form("body") {
            # fill the needed form inputs via capybara here
            #
            # Example:
            #
            #     select 'de', from: 'slider[locale]'
            #     fill_in 'slider[name]', with: 'My first slider'
            #     check 'slider[auto_start]'
            #     fill_in 'slider[interval]', with: '3'
            polymorphic_select(accountable, :human, from: "bank_account[accountable_id]")
            fill_in "bank_account[name]", with: "DKB Girokonto"
            fill_in "bank_account[owner]", with: "Jane Doe"
            fill_in "bank_account[iban]", with: "DE8112030000112345678"
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
        .within_form(".edit_bank_account") {
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
