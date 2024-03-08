require 'rails_helper'

RSpec.describe "/de/auth/benutzer/edit" do
  let(:base_path) { "/de/auth/benutzer/edit" }

  describe "authenticated access" do
    let(:user) { create(:bgit_frontend_auth_user, :authenticable) }

    before(:each) do
      sign_in(user)
      visit(base_path)
    end

    it { expect(current_path).to eq(base_path) }
    it { expect(page.body).to have_text(user.email) }

    describe "changing things" do
      let(:submit_button) { find("input[type=submit]") }
      
      before(:each) do
        fill_in "user[email]", with: "new-email@domain.local"
      end

      describe "response" do
        let(:show_path) { "/de/auth/benutzer" }
        before(:each) do
          submit_button.click
        end
        
        it { expect(current_path).to eq(show_path) }
      end

      describe "changes" do
        it { expect{ submit_button.click }.to change{ user.reload.email }.to("new-email@domain.local") }
      end
    end
  end

  describe "unauthenticated access" do
    let(:sign_in_path) { "/de/auth/session/new" }

    before(:each) do
      visit(base_path)
    end

    it { expect(current_path).to eq(sign_in_path) }
  end
end