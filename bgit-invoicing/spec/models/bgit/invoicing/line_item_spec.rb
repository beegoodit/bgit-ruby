require "rails_helper"

module Bgit::Invoicing
  RSpec.describe LineItem, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:invoice) }
      it { expect(subject).to belong_to(:subscription) } if Object.const_defined?("Bgit::Pricing")
    end

    describe "validations" do
      subject { create(:bgit_invoicing_line_item) }

      it { expect(subject).to validate_presence_of(:quantity) }
      it { expect(subject).to validate_presence_of(:unit_name) }
      it { expect(subject).to validate_presence_of(:unit_net_amount_cents) }
      it { expect(subject).to validate_presence_of(:tax_rate_percentage) }

      it { expect(subject).to validate_numericality_of(:quantity) }
      it { expect(subject).to validate_numericality_of(:unit_net_amount_cents) }
      it { expect(subject).to validate_numericality_of(:tax_rate_percentage) }

      describe "when used with Bgit::Pricing" do
        it { expect(subject).to validate_uniqueness_of(:subscription).scoped_to(:invoice_id).case_insensitive } if Object.const_defined?("Bgit::Pricing")
      end
    end
  end
end
