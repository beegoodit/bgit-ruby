require "rails_helper"

module Bgit::Lexoffice
  RSpec.describe Contact, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:contactable).optional }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:lexoffice_id) }
      it { expect(subject).to validate_uniqueness_of(:lexoffice_id) }
    end

    describe "#human" do
      it { expect(subject).to respond_to(:human) }
    end
  end
end
