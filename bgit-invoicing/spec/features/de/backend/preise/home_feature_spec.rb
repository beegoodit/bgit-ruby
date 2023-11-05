require "rails_helper"

RSpec.describe "/de/backend/preise", type: :feature do
  let(:base_path) { "/de/backend/preise" }

  before(:each) { visit(base_path) }

  it { expect(page).to have_text("Preise") }
end
