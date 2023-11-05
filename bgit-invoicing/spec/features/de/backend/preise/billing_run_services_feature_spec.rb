require "rails_helper"

RSpec.describe "/de/backend/preise/billing_run_services", type: :system, js: true do
  let(:base_path) { "/de/backend/preise/billing_run_services" }

  describe "basic usage" do
    let(:new_path) { "#{base_path}/new" }
    let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }

    before(:each) do
      visit(new_path)

      select I18n.t("date.month_names")[1.month.ago.strftime("%m").to_i], from: "billing_run_service[month]"
      select 1.month.ago.strftime("%Y"), from: "billing_run_service[year]"

      find("input[type=submit]").click
    end

    describe "UI" do
      it { expect(page).to have_text("Abrechnungen erstellen wurde ausgeführt.") }
    end
  end
end
