require "rails_helper"

RSpec.describe "/de/backend/abrechnung/invoices", type: :feature do
  let(:resource_class) { Bgit::Invoicing::Invoice }
  let(:resource) { create(:bgit_invoicing_invoice) }
  let(:resources) { create_list(:bgit_invoicing_invoice, 3) }

  let(:product) { create(:bgit_invoicing_product) }
  let(:team) { create(:team, name: "foo") }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  describe "create", type: :system, js: true do
    it {
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("body") {
          # we need to click the input field to trigger the datepicker.
          # Otherwise there will be two dates in the input field.
          find("#invoice_shipping_date").click

          fill_in "invoice[shipping_date]", with: Time.zone.now.beginning_of_month.strftime("%d.%m.%Y")
          polymorphic_select(team, :human, from: "invoice[owner_id]")
        }
        .increasing { resource_class.count }.by(1)
    }
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  describe "update", type: :system, js: true do
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_invoice") {
          # we need to click the input field to trigger the datepicker.
          # Otherwise there will be two dates in the input field.
          find("#invoice_shipping_end_date").click
          fill_in "invoice[shipping_end_date]", with: Time.zone.now.end_of_month.strftime("%d.%m.%Y")
          first("div").click # click outside of the input field to trigger the datepicker
        }
        .updating
        .from(resource.attributes)
        .to({"shipping_end_date" => Time.zone.now.end_of_month.to_date}) # Example: .to({ 'name' => 'New name' })
    }
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
