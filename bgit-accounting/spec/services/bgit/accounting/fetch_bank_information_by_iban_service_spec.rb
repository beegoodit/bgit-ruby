require "rails_helper"

RSpec.describe Bgit::Accounting::FetchBankInformationByIbanService, type: :service, vcr: true do
  describe "basic usage" do
    let(:iban) { "DE89370400440532013000" }
    let(:attributes) { {iban: iban} }
    let(:options) { {} }

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }

      it { expect(subject.iban_valid?).to be_truthy }
      it { expect(subject.bank_code).to eq("37040044") }
      it { expect(subject.name).to eq("Commerzbank") }
      it { expect(subject.zip).to eq("50447") }
      it { expect(subject.city).to eq("Köln") }
      it { expect(subject.bic).to eq("COBADEFFXXX") }
    end
  end
end
