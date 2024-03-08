require 'rails_helper'

RSpec.describe "/de/auth/benutzer/new", type: :feature do
  let(:base_path) { "/de/auth/benutzer/new" }
  
  describe "Accessing the page" do
    before(:each) do
      visit(base_path)
    end
  
    it { expect(page.body).to have_text("Registrieren") }
  end

  describe "Registering a new user" do
    let(:after_sign_up_path) { "/de/auth/benutzer" }
    let(:submit_button) { find("input[type=submit]") }

    before(:each) do
      visit(base_path)
      fill_in "user[email]", with: "user@example.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
    end

    describe "Response" do
      before(:each) do
        submit_button.click
      end

      it { expect(current_path).to eq(after_sign_up_path) }
    end

    describe "Changes" do
      it { expect{ submit_button.click }.to change { Bgit::FrontendAuth::User.count }.from(0).to(1) }
    end
  end
end
