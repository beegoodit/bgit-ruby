require "rails_helper"

RSpec.describe Bgit::Accounting::Vouchers::AssignVoucherService, type: :service do
  describe "basic usage" do
    let(:account) { create(:bgit_accounting_accounting_account) }
    let(:voucher) { create(:bgit_accounting_vouchers_voucher, :unchecked) }
    let(:attributes) {
      {
        voucher_id: voucher.id,
        type: "Bgit::Accounting::Vouchers::PurchaseInvoice",
        voucher_date: 7.days.ago,
        voucher_number: "INV-123456",
        amounts: [
          {net_amount: 1, tax_rate_percentage: 19, tax_amount: 0.19, account_id: account.id},
          {net_amount: 42, tax_rate_percentage: 7, tax_amount: 2.94, account_id: account.id}
        ]
      }
    }
    let(:options) { {autosave: true} }

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }
    end

    describe "persistence changes" do
      it { expect { subject.perform }.to change { Bgit::Accounting::Vouchers::Amount.count }.from(0).to(2) }
      it { expect { subject.perform }.to change { voucher.class.base_class.find(voucher.id).amount }.to(Money.new(4613, "EUR")) }
      it { expect { subject.perform }.to change { voucher.class.base_class.find(voucher.id).class }.from(Bgit::Accounting::Vouchers::Unchecked).to(Bgit::Accounting::Vouchers::PurchaseInvoice) }
    end
  end
end
