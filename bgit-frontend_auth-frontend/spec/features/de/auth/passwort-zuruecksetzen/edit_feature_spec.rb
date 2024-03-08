require 'rails_helper'

RSpec.describe "/de/auth/passwort-zuruecksetzen/edit/:perishable_token", type: :feature do
  let(:user) { create(:bgit_frontend_auth_user, :authenticable) }

  let(:base_path) { "/de/auth/passwort-zuruecksetzen/edit" }
  let(:edit_path) { "#{base_path}/#{user.perishable_token}" }
  
  describe "Accessing the page" do
    before(:each) do
      visit(edit_path)
    end
  
    it { expect(current_path).to eq(edit_path) }
    it { expect(page.body).to have_text("Passwort zurücksetzen") }
  end

  describe "Set new password" do
    let(:after_request_path) { "/de/auth/benutzer" }
    let(:submit_button) { find("input[type=submit]") }

    before(:each) do
      visit(edit_path)
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
    end

    describe "Response" do
      let(:success_message) { "Ihr Passwort wurde aktualisiert." }
      
      before(:each) do
        submit_button.click
      end

      it { expect(current_path).to eq(after_request_path) }
      it { expect(page.body).to have_text(success_message) }
    end
  end
end
