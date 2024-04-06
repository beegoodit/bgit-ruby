require "rails_helper"

RSpec.describe "/de/backend/accounting/vouchers/vouchers", type: :feature do
  let(:resource_class) { Bgit::Accounting::Vouchers::Voucher }

  describe "REST actions" do
    let(:resource) { create(:bgit_accounting_vouchers_voucher) }
    let(:resources) { create_list(:bgit_accounting_vouchers_voucher, 3) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    describe "Create", type: :system do
      let(:accountable) { create(:user) }

      before(:each) { accountable }

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
            polymorphic_select(accountable, :human, from: "vouchers_voucher[accountable_id]")
            select Bgit::Accounting::Vouchers::Voucher::VOUCHER_TYPES.first.constantize.model_name.human, from: "vouchers_voucher[type]"
            attach_file "vouchers_voucher[asset]", Bgit::Accounting::Engine.root.join(*%w[spec files bgit accounting vouchers vouchers example.pdf])
          }
          .increasing { resource_class.count }.by(1)
      }
    end

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    describe "Update", type: :system do
      let(:new_accountable) { create(:user) }

      before(:each) { new_accountable }

      it {
        expect(subject).to implement_update_action(self)
          .for(resource)
          .within_form("body") {
            # fill the needed form inputs via capybara here
            #
            # Example:
            #
            #     fill_in 'slider[name]', with: 'New name'
            polymorphic_select(new_accountable, :human, from: "vouchers_unchecked[accountable_id]")
          }
          .updating
          .from(resource.attributes)
          .to({"accountable_id" => new_accountable.id}) # Example: .to({ 'name' => 'New name' })
      }
    end

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing { resource_class.count }.by(1)
    }
  end
end
