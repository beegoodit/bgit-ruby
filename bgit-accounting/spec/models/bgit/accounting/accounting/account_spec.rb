require "rails_helper"

module Bgit::Accounting::Accounting
  RSpec.describe Account, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:account_category) }
      it { expect(subject).to belong_to(:accountable) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:account_number) }
      it { expect(subject).to validate_presence_of(:label) }
    end
  end
end
