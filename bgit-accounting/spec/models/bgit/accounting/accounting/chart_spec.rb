require "rails_helper"

module Bgit::Accounting
  RSpec.describe Accounting::Chart, type: :model do
    describe "associations" do
      it { expect(subject).to have_many(:account_categories) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier) }
      it { expect(subject).to validate_presence_of(:label) }
      it { expect(subject).to validate_uniqueness_of(:label) }
    end
  end
end
