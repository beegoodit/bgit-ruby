require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Resource, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:product) }
      it { expect(subject).to belong_to(:owner) }
    end

    describe "validations" do
      subject { build(:bgit_invoicing_resource) }

      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier).scoped_to(:product_id) }
    end

    it { expect(subject).to respond_to(:human) }
  end
end
