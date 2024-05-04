require "rails_helper"

RSpec.describe Bgit::Invoicing::NumberRanges::NextNumberService, type: :service do
  include ActiveSupport::Testing::TimeHelpers

  describe "basic usage" do
    let(:attributes) { {identifier: "invoice_number"} }
    let(:options) { {} }

    subject { described_class.new(attributes, options) }

    before { Bgit::Invoicing::NumberRanges::SeedService.call! }

    around(:each) do |example|
      travel_to(Time.zone.local(2023, 7, 1, 12, 0, 0)) { example.run }
    end

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }

      describe "value" do
        it { expect(subject.value).to eq("RE202307-0001") }
      end
    end
  end

  describe "consecutive calls" do
    before(:each) { Bgit::Invoicing::NumberRanges::SeedService.call! }

    around(:each) do |example|
      travel_to(Time.zone.local(2023, 7, 1, 12, 0, 0)) { example.run }
    end

    it "returns the next value" do
      expect(described_class.call!(identifier: "invoice_number").value).to eq("RE202307-0001")
      expect(described_class.call!(identifier: "invoice_number").value).to eq("RE202307-0002")
      expect(described_class.call!(identifier: "invoice_number").value).to eq("RE202307-0003")
    end
  end
end
