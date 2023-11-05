require "rails_helper"

RSpec.describe "/de/backend/preise/line_items", type: :feature do
  let(:resource_class) { Bgit::Invoicing::LineItem }
  let(:resource) { create(:bgit_invoicing_line_item) }
  let(:resources) { create_list(:bgit_invoicing_line_item, 3) }

  let(:product) { create(:bgit_invoicing_product) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
