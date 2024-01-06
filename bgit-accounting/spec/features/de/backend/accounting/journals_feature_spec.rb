require "rails_helper"

RSpec.describe "/de/backend/accounting/journals", type: :feature do
  let(:resource_class) { Keepr::Journal }

  describe "REST actions" do
    let(:resource) { create(:journal) }
    let(:resources) { create_list(:journal, 3) }

    let(:debit_account) { create(:account, number: "1000", name: "Bank", kind: "asset") }
    let(:credit_account) { create(:account, number: "2000", name: "Sales", kind: "revenue") }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    describe "create", type: :system, js: true do
      it {
        debit_account
        credit_account
        expect(subject).to implement_create_action(self)
          .for(resource_class)
          .within_form("#new_keepr_journal") {
            # fill the needed form inputs via capybara here
            #
            # Example:
            #
            #     select 'de', from: 'slider[locale]'
            #     fill_in 'slider[name]', with: 'My first slider'
            #     check 'slider[auto_start]'
            #     fill_in 'slider[interval]', with: '3'

            click_on "Buchung hinzufügen"
            within "#keepr_postings .nested-fields:nth-child(1)" do
              find(:xpath, ".//select[contains(@name, '[keepr_account_id]')]").select debit_account.to_s
              find(:xpath, ".//input[contains(@name, '[amount]')]").set "100"
              find(:xpath, ".//select[contains(@name, '[side]')]").select Keepr::Posting.human_value_name(:side, :debit)
            end

            click_on "Buchung hinzufügen"
            within "#keepr_postings .nested-fields:nth-child(2)" do
              find(:xpath, ".//select[contains(@name, '[keepr_account_id]')]").select credit_account.to_s
              find(:xpath, ".//input[contains(@name, '[amount]')]").set "100"
              find(:xpath, ".//select[contains(@name, '[side]')]").select Keepr::Posting.human_value_name(:side, :credit)
            end
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
        .within_form(".edit_keepr_journal") {
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
