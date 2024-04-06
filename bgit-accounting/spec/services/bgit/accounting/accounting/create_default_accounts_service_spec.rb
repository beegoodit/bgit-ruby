require "rails_helper"

RSpec.describe Bgit::Accounting::Accounting::CreateDefaultAccountsService, type: :service do
  describe "basic usage" do
    let(:accountable) { create(:user) }
    let(:attributes) { {accountable: accountable} }
    let(:options) { {autosave: true} }

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }
    end

    describe "persistence changes" do
      it { expect { subject.perform }.to change { Bgit::Accounting::Accounting::Account.count }.from(0).to(39) }
    end
  end
end
