require "rails_helper"

module Bgit::Accounting
  RSpec.describe Vouchers::Amount, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:voucher) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:net_amount_cents) }
      it { expect(subject).to validate_presence_of(:tax_amount_cents) }
      it { expect(subject).to validate_presence_of(:tax_rate_percentage) }
    end
  end
end
