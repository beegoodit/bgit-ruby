require "rails_helper"

RSpec.describe "/de/backend/preise/generate_invoice_for_owner_services", type: :system, js: true do
  let(:base_path) { "/de/backend/preise/generate_invoice_for_owner_services" }

  describe "basic usage" do
    let(:new_path) { "#{base_path}/new" }
    let(:bgit_frontend_auth_user) { create(:bgit_frontend_auth_user) }

    before(:each) do
      visit(new_path)

      fill_in("generate_invoice_for_owner_service[year]", with: 1.month.ago.beginning_of_month.strftime("%Y"))
      fill_in("generate_invoice_for_owner_service[month]", with: 1.month.ago.beginning_of_month.strftime("%m"))

      select bgit_frontend_auth_user.class.model_name.human, from: "generate_invoice_for_owner_service[owner_type]"
      first(".select2-container", minimum: 1).click
      find(".select2-search--dropdown input.select2-search__field").send_keys(bgit_frontend_auth_user.human)
      sleep(1)
      find(".select2-search--dropdown input.select2-search__field").send_keys(:enter)

      find("input[type=submit]").click
    end

    describe "UI" do
      it { expect(page).to have_text("Rechnung für Besitzer erstellen wurde ausgeführt.") }
    end
  end
end
