require "rails_helper"

RSpec.describe Bgit::Accounting::Banking::ImportN26StatementsService, type: :service do
  describe "basic usage" do
    let(:account) { create(:bgit_accounting_banking_account) }
    let(:csv_data) { File.read(Bgit::Accounting::Engine.root.join(*%w[spec files bgit accounting import_n26_statements_service n26-csv-transactions.csv])) }
    let(:attributes) { {csv_data: csv_data, account: account} }
    let(:options) { {autosave: true} }

    before(:each) { Bgit::Accounting::SeedService.call! }

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }

      describe "parsed_csv" do
        subject { super().parsed_csv }

        it { expect(subject).to be_a(CSV::Table) }
        it { expect(subject.size).to eq(207) }
      end
    end

    describe "persistence changes" do
      before(:each) { account }

      it { expect { subject.perform }.to change { Bgit::Accounting::Banking::Account.count }.from(1).to(49) }
      it { expect { subject.perform }.to change { Bgit::Accounting::Banking::Transfer.count }.from(0).to(207) }
    end
  end
end
