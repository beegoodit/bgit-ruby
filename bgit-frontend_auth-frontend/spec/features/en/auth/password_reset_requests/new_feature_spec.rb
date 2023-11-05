require 'rails_helper'

RSpec.describe "/en/auth/password_reset_request/new", type: :feature do
  let(:base_path) { "/en/auth/password_reset_request/new" }
  
  describe "Accessing the page" do
    before(:each) do
      visit(base_path)
    end
  
    it { expect(current_path).to eq(base_path) }
    it { expect(page.body).to have_text("Forgot password?") }
  end

  describe "Request new password" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }
    let(:after_request_path) { "/en/auth/session/new" }
    let(:submit_button) { find("input[type=submit]") }

    before(:each) do
      visit(base_path)
      fill_in "password_reset_request[email]", with: user.email
    end

    describe "Response" do
      let(:success_message) { "An email with instructions for creating a new password has been sent to you." }

      before(:each) do
        submit_button.click
      end

      it { expect(current_path).to eq(after_request_path) }
      it { expect(page.body).to have_text(success_message) }
    end

    describe 'Mail delivery' do
      before(:each) { ActionMailer::Base.deliveries = [] }

      it { expect { submit_button.click }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1) }
    end
  end
end
