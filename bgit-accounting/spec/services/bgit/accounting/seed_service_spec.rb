require "rails_helper"

RSpec.describe Bgit::Accounting::SeedService, type: :service do
  describe "basic usage" do
    let(:attributes) { {} }
    let(:options) { {autosave: true} }
    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }
    end

    describe "persistence changes" do
      it { expect { subject.perform }.to change { Keepr::Group.count }.from(0).to(3) }
      it { expect { subject.perform }.to change { Keepr::Account.count }.from(0).to(3) }
    end
  end
end
