require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Tier, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:product) }
    end

    describe "validations" do
      subject { build(:bgit_invoicing_tier) }

      it { expect(subject).to validate_identifiability_of(:identifier) }
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier).scoped_to(:product_id) }
      it { expect(subject).to validate_presence_of(:price_per_month_cents) }
      it { expect(subject).to validate_numericality_of(:price_per_month_cents).is_greater_than_or_equal_to(0) }
      it { expect(subject).to validate_presence_of(:available_from) }
      it { expect(subject).to validate_presence_of(:available_to) }
    end

    it { expect(subject).to respond_to(:human) }
    it { expect(subject).to respond_to(:price_per_month) }
  end
end
