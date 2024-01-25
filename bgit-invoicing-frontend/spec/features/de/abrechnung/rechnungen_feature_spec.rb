require "rails_helper"

RSpec.describe "/de/abrechnung/rechnungen", type: :feature do
  let(:base_path) { "/de/abrechnung/rechnungen" }

  describe "when not authenticated" do
    it "redirects to the login page" do
      visit base_path
      expect(page).to have_current_path("/de/auth/session/new")
    end
  end

  describe "when authenticated" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }

    before(:each) do
      sign_in(user)
      visit(base_path)
    end

    it { expect(page).to have_current_path(base_path) }
  end
end