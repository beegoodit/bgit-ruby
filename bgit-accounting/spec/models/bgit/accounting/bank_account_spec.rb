require "rails_helper"

RSpec.describe Bgit::Accounting::BankAccount, type: :model do
  describe "associations" do
    it { expect(subject).to belong_to(:accountable).optional }
    it { expect(subject).to have_many(:incoming_transfers) }
    it { expect(subject).to have_many(:outgoing_transfers) }
  end

  describe "validations" do
    subject { build(:bgit_accounting_bank_account) }

    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:iban) }
    it { expect(subject).to validate_presence_of(:active_from) }
    it { expect(subject).to validate_presence_of(:active_to) }
    it { expect(subject).to validate_uniqueness_of(:iban) }
  end
end
