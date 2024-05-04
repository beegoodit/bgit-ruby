require "rails_helper"

RSpec.describe "/de/backend/accounting/vouchers/create_services", type: :feature do
  let(:base_path) { "/de/backend/accounting/vouchers/create_services" }

  describe "basic usage" do
    before(:each) { visit(base_path) }

    it { expect(page).to have_current_path(base_path) }
  end
end
