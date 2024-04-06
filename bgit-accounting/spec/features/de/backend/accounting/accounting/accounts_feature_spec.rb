require "rails_helper"

RSpec.describe "/de/backend/accounting/accounting/accounts", type: :feature do
  let(:resource_class) { Bgit::Accounting::Accounting::Account }

  describe "REST actions" do
    let(:resource) { create(:bgit_accounting_accounting_account) }
    let(:resources) {
      build_list(:bgit_accounting_accounting_account, 3) { |resource, index|
        resource.account_number = "100#{index}"
        resource.save!
      }
    }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    describe "Create", type: :system do
      let(:accountable) { create(:user) }
      let(:account_category) { create(:bgit_accounting_accounting_account_category) }

      before(:each) do
        accountable
        account_category
      end

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
            select account_category.human, from: "accounting_account[account_category_id]"
            polymorphic_select(accountable, :human, from: "accounting_account[accountable_id]")
            fill_in "accounting_account[account_number]", with: "51000"
            fill_in "accounting_account[label]", with: "Einkauf Roh-,Hilfs- und Betriebsstoffe"
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
        .within_form(".edit_accounting_account") {
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
