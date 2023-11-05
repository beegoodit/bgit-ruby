require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Invoice, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:owner) }
      it { expect(subject).to have_many(:line_items) }
    end

    describe "validations" do
      subject { create(:bgit_invoicing_invoice) }

      it { expect(subject).to validate_presence_of(:owner) }
      it { expect(subject).to validate_presence_of(:year) }
      it { expect(subject).to validate_presence_of(:month) }
      it { expect(subject).to validate_uniqueness_of(:month).scoped_to([:owner_id, :owner_type, :year]).case_insensitive }
    end
  end
end
