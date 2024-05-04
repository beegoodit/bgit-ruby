require "rails_helper"

RSpec.describe Bgit::Accounting::Banking::Transfer, type: :model do
  describe "validations" do
    it { expect(subject).to validate_presence_of(:value_at) }
    it { expect(subject).to validate_presence_of(:amount_cents) }
  end

  describe "associations" do
    it { expect(subject).to belong_to(:recipient_bank_account) }
    it { expect(subject).to belong_to(:sender_bank_account) }
  end

  describe "digest concern" do
    subject { build(:bgit_accounting_banking_transfer) }

    describe "validations" do
      # it { expect(subject).to validate_presence_of(:digest) }
      # it { expect(subject).to validate_uniqueness_of(:digest) }
    end

    it { expect(subject).to respond_to(:digest) }

    describe "digest" do
      subject { super().digest }

      it { expect(subject).to be_present }
    end
  end

  it { expect(subject).to respond_to(:amount) }
end
