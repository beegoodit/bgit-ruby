require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::Person, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:contact) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_person) }

      it { expect(subject).to validate_presence_of(:salutation) }
      it { expect(subject).to validate_presence_of(:firstname) }
      it { expect(subject).to validate_presence_of(:lastname) }
    end
  end
end
