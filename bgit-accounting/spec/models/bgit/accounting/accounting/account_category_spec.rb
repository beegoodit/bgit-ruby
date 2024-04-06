require "rails_helper"

module Bgit::Accounting
  RSpec.describe Accounting::AccountCategory, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:chart) }
      it { expect(subject).to have_many(:accounts) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_accounting_account_category) }

      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier) }
      it { expect(subject).to validate_presence_of(:label) }
      it { expect(subject).to validate_uniqueness_of(:label) }
      it { expect(subject).to validate_presence_of(:side) }
      it {
        pending
        expect(subject).to validate_inclusion_of(:side).in_array(%w[income expense])
      }
    end
  end
end
