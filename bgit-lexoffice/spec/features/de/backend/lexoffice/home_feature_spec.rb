require "rails_helper"

RSpec.describe "/de/backend/lexoffice", type: :feature do
  let(:base_path) { "/de/backend/lexoffice" }

  before(:each) { visit(base_path) }

  it { expect(page).to have_text("Lexoffice") }
end
