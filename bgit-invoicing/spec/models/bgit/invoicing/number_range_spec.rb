require "rails_helper"

module Bgit::Invoicing
  RSpec.describe NumberRange, type: :model do
    describe "validations" do
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier) }
      it { expect(subject).to validate_presence_of(:next_value) }
      it { expect(subject).to validate_numericality_of(:next_value).is_greater_than_or_equal_to(1) }
      it { expect(subject).to validate_presence_of(:format) }
      it { expect(subject).to validate_presence_of(:minimum_length) }
      it { expect(subject).to validate_numericality_of(:minimum_length).is_greater_than_or_equal_to(1) }
      it { expect(subject).to validate_presence_of(:prefix) }
      it { expect(subject).to validate_uniqueness_of(:prefix) }
    end

    describe "defaults" do
      it { expect(subject.next_value).to eq(1) }
      it { expect(subject.format).to eq("%Y%m-") }
      it { expect(subject.minimum_length).to eq(4) }
    end
  end
end
