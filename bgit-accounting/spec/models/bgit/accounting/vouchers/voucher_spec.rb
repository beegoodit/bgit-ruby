require "rails_helper"

module Bgit::Accounting
  RSpec.describe Vouchers::Voucher, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:accountable) }
      it { expect(subject).to have_many(:amounts) }
    end

    describe "validations" do
      it { should validate_presence_of(:asset) }
    end
  end
end
