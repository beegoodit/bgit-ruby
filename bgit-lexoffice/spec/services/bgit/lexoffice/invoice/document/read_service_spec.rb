require "rails_helper"

RSpec.describe Bgit::Lexoffice::Invoice::Document::ReadService, type: :service, vcr: true do
  before(:each) do
    allow(LexofficeClient::Configuration).to receive(:api_base_url).and_return("https://api.lexoffice.io/v1")
    allow(LexofficeClient::Configuration).to receive(:api_token).and_return("n2.o0c.raladGqUDySbv9ZKZaNKME0pf7W3YulfNjlaTV1TC")
  end

  describe "basic usage" do
    let(:invoice) { create(:bgit_lexoffice_invoice, lexoffice_id: "57caf899-8278-4540-b234-80177576416f") }
    subject { described_class.new(invoice_id: invoice.lexoffice_id) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }
    end

    describe "persistence" do
      subject { super() }

      describe "when autosave is disabled" do
        it { expect { subject.perform }.not_to change { invoice.reload.lexoffice_document.attached? } }
      end

      describe "when autosave is enabled" do
        before(:each) { subject.autosave! }

        it { expect { subject.perform }.to change { invoice.reload.lexoffice_document.attached? }.from(false).to(true) }
      end
    end
  end
end
