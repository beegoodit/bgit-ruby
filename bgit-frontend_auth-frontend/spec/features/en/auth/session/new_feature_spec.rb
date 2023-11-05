require 'rails_helper'

RSpec.describe "/en/auth/session/new", type: :feature do
  let(:base_path) { "/en/auth/session/new" }
  
  describe "Accessing the page" do
    before(:each) do
      visit(base_path)
    end
  
    it { expect(page.body).to have_text("Sign in") }
  end

  describe "Signing in a user" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }
    let(:after_sign_in_path) { "/" }
    let(:submit_button) { find("input[type=submit]") }

    before(:each) do
      visit(base_path)
      fill_in "user_session[email]", with: user.email
      fill_in "user_session[password]", with: user.password
    end

    describe "Response" do
      before(:each) do
        submit_button.click
      end

      it { expect(current_path).to eq(after_sign_in_path) }
    end
  end
end
