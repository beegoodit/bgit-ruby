require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Invoice, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:owner) }
      it { expect(subject).to have_many(:line_items) }
    end

    describe "scopes" do
      it { expect(described_class).to respond_to(:for_year) }
    end

    describe "validations" do
      subject { create(:bgit_invoicing_invoice) }

      it { expect(subject).to validate_presence_of(:owner) }
      it { expect(subject).to validate_presence_of(:shipping_date) }
    end
  end
end
