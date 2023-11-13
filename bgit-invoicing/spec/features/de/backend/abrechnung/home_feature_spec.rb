require "rails_helper"

RSpec.describe "/de/backend/abrechnung", type: :feature do
  let(:base_path) { "/de/backend/abrechnung" }

  before(:each) { visit(base_path) }

  it { expect(page).to have_text("Abrechnung") }
end
