require "rails_helper"

RSpec.describe "/de/backend/abrechnung/number_ranges", type: :feature do
  let(:resource_class) { Bgit::Invoicing::NumberRange }
  let(:resource) { create(:bgit_invoicing_number_range) }
  let(:resources) { create_list(:bgit_invoicing_number_range, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_number_range") {
        # we need to click the input field to trigger the datepicker.
        # Otherwise there will be two dates in the input field.
        fill_in "number_range[format]", with: "%Y%m-"
        fill_in "number_range[identifier]", with: "invoice_number"
        fill_in "number_range[minimum_length]", with: "4"
        fill_in "number_range[next_value]", with: "1337"
        fill_in "number_range[prefix]", with: "RE"
      }
      .increasing { resource_class.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_number_range") {
        # we need to click the input field to trigger the datepicker.
        # Otherwise there will be two dates in the input field.
        fill_in "number_range[next_value]", with: "42"
      }
      .updating
      .from(resource.attributes)
      .to({"next_value" => 42}) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
