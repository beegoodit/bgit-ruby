require 'rails_helper'

RSpec.describe "/en/auth/user" do
  let(:base_path) { "/en/auth/user" }

  describe "authenticated access" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }

    before(:each) do
      sign_in(user)
      visit(base_path)
    end

    it { expect(current_path).to eq(base_path) }
    it { expect(page.body).to have_text(user.email) }
  end

  describe "unauthenticated access" do
    let(:sign_in_path) { "/en/auth/session/new" }

    before(:each) do
      visit(base_path)
    end

    it { expect(current_path).to eq(sign_in_path) }
  end
end