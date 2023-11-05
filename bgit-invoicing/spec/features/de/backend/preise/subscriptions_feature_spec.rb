require "rails_helper"

RSpec.describe "/de/backend/preise/subscriptions", type: :feature do
  let(:resource_class) { Bgit::Invoicing::Subscription }
  let(:resource) { create(:bgit_invoicing_subscription) }
  let(:resources) { create_list(:bgit_invoicing_subscription, 3) }

  let(:bgit_invoicing_tier) { create(:bgit_invoicing_tier) }
  let(:bgit_invoicing_resource) { create(:bgit_invoicing_resource) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    bgit_invoicing_tier
    bgit_invoicing_resource
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_subscription") {
        select bgit_invoicing_tier.human, from: "subscription[tier_id]"
        select bgit_invoicing_resource.human, from: "subscription[resource_id]"
        fill_in "subscription[active_from]", with: Time.zone.now.beginning_of_month.strftime("%d.%m.%Y %H:%M:%S")
        fill_in "subscription[active_to]", with: Time.zone.now.end_of_month.strftime("%d.%m.%Y %H:%M:%S")
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it {
    expect(subject).to implement_show_action(self).for(resource)
  }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_subscription") {
        fill_in "subscription[active_to]", with: Time.zone.now.end_of_year.strftime("%d.%m.%Y %H:%M:%S")
      }
      .updating
      .from(resource.attributes)
      .to({"active_to" => Time.zone.now.end_of_year.strftime("%d.%m.%Y %H:%M:%S")})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
