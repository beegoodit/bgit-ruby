require "rails_helper"

module Bgit::Invoicing
  RSpec.describe LineItem, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:invoice) }
      it { expect(subject).to belong_to(:subscription) }
    end

    describe "validations" do
      subject { create(:bgit_invoicing_line_item) }

      it { expect(subject).to validate_presence_of(:seconds) }
      it { expect(subject).to validate_numericality_of(:price_cents) }
      it { expect(subject).to validate_uniqueness_of(:subscription).scoped_to(:invoice_id).case_insensitive }
    end
  end
end
