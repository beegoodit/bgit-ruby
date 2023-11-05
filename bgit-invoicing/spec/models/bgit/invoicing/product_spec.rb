require "rails_helper"

module Bgit::Invoicing
  RSpec.describe Product, type: :model do
    describe "associations" do
      it { expect(subject).to have_many(:tiers) }
      it { expect(subject).to have_many(:resources) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier) }
      it { expect(subject).to validate_identifiability_of(:identifier) }
    end

    it { expect(subject).to respond_to(:human) }
  end
end
