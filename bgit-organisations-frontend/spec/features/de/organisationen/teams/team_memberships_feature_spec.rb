require "rails_helper"

RSpec.describe "/de/organisationen/teams/:id/team_memberships", type: :feature do
  let(:team) { create(:bgit_organisations_team) }
  let(:base_path) { "/de/organisationen/teams/#{team.id}/team_memberships" }

  describe "when not authenticated" do
    it "redirects to the login page" do
      visit base_path
      expect(page).to have_current_path("/de/auth/session/new")
    end
  end

  describe "when authenticated" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }
    let(:team) { create(:bgit_organisations_team) }
    let(:team_membership) { create(:bgit_organisations_team_membership, team: team, member: user) }

    before(:each) do
      team_membership
      sign_in(user)
      visit(base_path)
    end

    it { expect(page).to have_current_path(base_path) }
  end
end
