require "rails_helper"

RSpec.describe Bgit::Accounting::Transfer, type: :model do
  describe "validations" do
    it { expect(subject).to validate_presence_of(:value_at) }
    it { expect(subject).to validate_presence_of(:amount_cents) }
  end

  describe "associations" do
    it { expect(subject).to belong_to(:recipient_bank_account) }
    it { expect(subject).to belong_to(:sender_bank_account) }
  end

  it { expect(subject).to respond_to(:amount) }
end
