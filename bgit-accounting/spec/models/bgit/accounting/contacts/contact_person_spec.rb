require "rails_helper"

module Bgit::Accounting
  RSpec.describe Contacts::ContactPerson, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:company) }
    end

    describe "validations" do
      subject { build(:bgit_accounting_contacts_contact_person) }

      it { expect(subject).to validate_presence_of(:salutation) }
      it { expect(subject).to validate_presence_of(:firstname) }
      it { expect(subject).to validate_presence_of(:lastname) }
      it { expect(subject).to validate_inclusion_of(:primary).in_array([true, false]) }
    end
  end
end
