require "rails_helper"

RSpec.describe Bgit::Lexoffice::Invoice::CreateService, type: :service, vcr: true do
  include ActiveSupport::Testing::TimeHelpers

  before(:each) do
    allow(LexofficeClient::Configuration).to receive(:api_token).and_return("n2.o0c.raladGqUDySbv9ZKZaNKME0pf7W3YulfNjlaTV1TC")
    allow(LexofficeClient::Configuration).to receive(:api_base_url).and_return("https://api.lexoffice.io/v1")

    # delete vcr cassettes
    # FileUtils.rm_rf(Dir["#{Bgit::Lexoffice::Engine.root}/spec/cassettes/Bgit_Lexoffice_Invoice_CreateService"])
  end

  around do |example|
    # In europe/berlin timezone
    Time.use_zone("Europe/Berlin") do
      # travel to the beginning of the next month
      travel_to Time.zone.now.at_beginning_of_month.next_month do
        example.run
      end
    end
  end

  describe "basic usage" do
    # The lexoffice_id of the contact has to be real and present in the lexoffice account, otherwise the request will fail.
    let(:lexoffice_contact) { create(:bgit_lexoffice_contact, contactable: user, lexoffice_id: "901e2da9-7753-46c9-8921-b3d463e04857") }
    let(:user) { create(:user) }
    let(:invoice) { create(:bgit_invoicing_invoice, owner: user) }
    let(:line_items) { create_list(:bgit_invoicing_line_item, 3, invoice: invoice) }

    before(:each) do
      lexoffice_contact
      line_items
    end

    subject { described_class.new(invoice: invoice) }

    describe "result" do
      subject { described_class.call(invoice: invoice) }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to be_empty }
    end

    describe "persistence changes" do
      subject { described_class.new(invoice: invoice) }

      it { expect { subject.perform }.to change { Bgit::Lexoffice::Invoice.count }.from(0).to(1) }

      describe "lexoffice_invoice" do
        subject { described_class.call(invoice: invoice).lexoffice_invoice }

        it { expect(subject).to be_a(Bgit::Lexoffice::Invoice) }
        it { expect(subject).to be_persisted }
        it { expect(subject.invoiceable).to eq(invoice) }
        it { expect(subject.lexoffice_id).to be_present }
      end

      describe "created invoice at lexoffice" do
        let(:lexoffice_invoice) { described_class.call(invoice: invoice).lexoffice_invoice }

        subject { LexofficeClient::Invoice::ReadService.call(invoice_id: lexoffice_invoice.lexoffice_id) }

        it { expect(subject.invoice).to be_a(LexofficeClient::Invoice) }
        it { expect(subject.invoice.voucher_date).to eq("2023-10-01T00:00:00.000+02:00") }
        it { expect(subject.invoice.shipping_conditions.shipping_date).to eq("2023-09-01T00:00:00.000+02:00") }
        it { expect(subject.invoice.shipping_conditions.shipping_end_date).to eq("2023-09-30T23:59:59.999+02:00") }
      end
    end
  end
end
