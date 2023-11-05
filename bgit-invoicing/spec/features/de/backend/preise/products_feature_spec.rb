require "rails_helper"

RSpec.describe "/de/backend/preise/products", type: :feature do
  let(:resource_class) { Bgit::Invoicing::Product }
  let(:resource) { create(:bgit_invoicing_product) }
  let(:resources) { create_list(:bgit_invoicing_product, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_product") {
        fill_in "product[identifier]", with: "product-1"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_product") {
        fill_in "product[identifier]", with: "product-2"
      }
      .updating
      .from(resource.attributes)
      .to({"identifier" => "product-2"})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
