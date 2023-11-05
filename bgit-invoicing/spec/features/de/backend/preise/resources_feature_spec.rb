require "rails_helper"

RSpec.describe "/de/backend/preise/resources", type: :feature do
  let(:resource_class) { Bgit::Invoicing::Resource }
  let(:resource) { create(:bgit_invoicing_resource) }
  let(:resources) { create_list(:bgit_invoicing_resource, 3) }

  let(:product) { create(:bgit_invoicing_product) }
  let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  describe "create", type: :system, js: true do
    it do
      product
      bgit_frontend_auth_user
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("body") {
          select product.human, from: "resource[product_id]"
          fill_in "resource[identifier]", with: "resource-1"

          select bgit_frontend_auth_user.class.model_name.human, from: "resource[owner_type]"
          first(".select2-container", minimum: 1).click
          find(".select2-search--dropdown input.select2-search__field").send_keys(bgit_frontend_auth_user.human)
          sleep(1)
          find(".select2-search--dropdown input.select2-search__field").send_keys(:enter)
        }.increasing { resource_class.count }.by(1)
    end
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_resource") {
        fill_in "resource[identifier]", with: "resource-2"
      }
      .updating
      .from(resource.attributes)
      .to({"identifier" => "resource-2"})
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
