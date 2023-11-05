require "rails_helper"

RSpec.describe "/de/backend/preise/tiers", type: :feature do
  let(:resource_class) { Bgit::Invoicing::Tier }
  let(:resource) { create(:bgit_invoicing_tier) }
  let(:resources) { create_list(:bgit_invoicing_tier, 3) }

  let(:product) { create(:bgit_invoicing_product) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    product
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_tier") {
        select product.human, from: "tier[product_id]"
        fill_in "tier[identifier]", with: "tier-1"
        fill_in "tier[price_per_month]", with: "7" # 7€
        fill_in "tier[available_from]", with: Time.zone.now.beginning_of_year.strftime("%d.%m.%Y %H:%M:%S")
        fill_in "tier[available_to]", with: Time.zone.now.end_of_year.strftime("%d.%m.%Y %H:%M:%S")
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_tier") {
        fill_in "tier[identifier]", with: "tier-2"
      }
      .updating
      .from(resource.attributes)
      .to({"identifier" => "tier-2"})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
